config.project ="roxweb"
config.fab_hosts = ["roxanne-lee.com",]
config.fab_user = "rox"


def deploy():
	
	local("git archive --format=tar HEAD | gzip > $(project).tar.gz")
	put("$(project).tar.gz", "$(project).tar.gz")
	run("ls -l")
    	
