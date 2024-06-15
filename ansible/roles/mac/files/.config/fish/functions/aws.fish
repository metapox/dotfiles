
function get-instance-id
    set -l instance_name ""
    set -l instance_id ""

    set instance_name $argv[(math $OPTIND + 1)]

    if test -z $instance_name
        echo "Usage: get-instance-id -n <instance_name> [-r]"
        return 1
    end

    set -l instance_info (aws ec2 describe-instances --filters "Name=tag:Name,Values=$instance_name" --query "Reservations[].Instances[].[InstanceId,LaunchTime,State.Name]" --output text | fzf --select-1 --header "InstanceId LaunchTime State" --with-nth 1,2,3)
    set -l instance_id (echo "$instance_info" | awk '{print $1}')

    if test -z $instance_id
        return 1
    end

    echo $instance_id
end