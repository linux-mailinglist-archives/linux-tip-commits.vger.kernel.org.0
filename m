Return-Path: <linux-tip-commits+bounces-3059-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AF79F17B6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 22:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445FC188F795
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 21:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFF21925BB;
	Fri, 13 Dec 2024 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eRPjdZaH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m23ZVsWD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D018E02A;
	Fri, 13 Dec 2024 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123761; cv=none; b=lH5/zoMiFLtgA9XZEb3z1cMXgq/8QUMcAl36YU0XXvyFhrRQKv6Izlxni+Gh+tFS03KoAkxb7w/jS1Vp7TWfVn8iE+PhbCwLyb3jZEBilDdOaD8oQ1Oi1/eSDYPpcsplNn8FhU7SkNXnoJwFV3qqS8GsfYtTWH0SxVrYcJ0Zd/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123761; c=relaxed/simple;
	bh=iH76lOCNGh8ipXP55WZiec8f5m24BjAoXHROTQHSg2E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XMdTQxSwEq6aZSVgBXiOWPst4khH6TLBszC/M/TZtx2+GG4xAK8eproDp3lPVksMGRmW7nq/vHTSs+GceSosQxrprI4XbjBukFhyoOGY2jP/GHzUjtOyAnry10oLGk3RCavEpPc1hQ7NhmyH3AVSq0rj5zcMLAk+Dy5G1TKEWgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eRPjdZaH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m23ZVsWD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Dec 2024 21:02:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734123757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DITsRtKiV4azuPxI3vZ1IwvP6xs6EkYl3lQglGGfBA=;
	b=eRPjdZaHJQAabk73IyiGpk0FTRv2sssCFKQQ7/TqXn6aBl9LGUHRceq4JqEbM8is/+qs6V
	j6OP3FFPkWL1Jk/0w7ePQk80iJFT4+cg211CTyERigng47qskgAre3YTYsXZq3n7VfVVB+
	LRHbw36ohCcUggfVkn8P+F5XwVUZx2RxAUp968faEhh883+tBCBTaNc4cD6tj29z56EdrZ
	a/i2PqqZgZOltDd+7zUeUqJJCqioOxG2X8tN5sIj9x+hQdMnTdUgnrwL1fAWLlkyDF3van
	UUvpVTONBuXeQ9zecXuopd26cBcUixybIYDEs1iB8Y1n/ANFYJmwKGKo7Zc/5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734123757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DITsRtKiV4azuPxI3vZ1IwvP6xs6EkYl3lQglGGfBA=;
	b=m23ZVsWDK69GlP/6ZWEirW78A9EN8mYW9SH7b7Bz1+r35pBGExBI9Afspnv/jyYLks61JS
	7JONdC9QLcHzCBDw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Add write option to "mba_MBps_event" file
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206163148.83828-8-tony.luck@intel.com>
References: <20241206163148.83828-8-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173412375583.412.16154414070225269835.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     8e931105acae688ff0fc8f875a6c05e5aed8ab79
Gitweb:        https://git.kernel.org/tip/8e931105acae688ff0fc8f875a6c05e5aed8ab79
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 06 Dec 2024 08:31:47 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 12 Dec 2024 11:27:37 +01:00

x86/resctrl: Add write option to "mba_MBps_event" file

The "mba_MBps" mount option provides an alternate method to control memory
bandwidth. Instead of specifying allowable bandwidth as a percentage of
maximum possible, the user provides a MiB/s limit value.

There is a file in each CTRL_MON group directory that shows the event
currently in use.

Allow writing that file to choose a different event.

A user can choose any of the memory bandwidth monitoring events listed in
/sys/fs/resctrl/info/L3_mon/mon_features independently for each CTRL_MON group
by writing to each of the "mba_MBps_event" files.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20241206163148.83828-8-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 40 ++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  3 +-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 5fa37b4..5363511 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -518,6 +518,46 @@ static int smp_mon_event_count(void *arg)
 	return 0;
 }
 
+ssize_t rdtgroup_mba_mbps_event_write(struct kernfs_open_file *of,
+				      char *buf, size_t nbytes, loff_t off)
+{
+	struct rdtgroup *rdtgrp;
+	int ret = 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+	buf[nbytes - 1] = '\0';
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+	rdt_last_cmd_clear();
+
+	if (!strcmp(buf, "mbm_local_bytes")) {
+		if (is_mbm_local_enabled())
+			rdtgrp->mba_mbps_event = QOS_L3_MBM_LOCAL_EVENT_ID;
+		else
+			ret = -EINVAL;
+	} else if (!strcmp(buf, "mbm_total_bytes")) {
+		if (is_mbm_total_enabled())
+			rdtgrp->mba_mbps_event = QOS_L3_MBM_TOTAL_EVENT_ID;
+		else
+			ret = -EINVAL;
+	} else {
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		rdt_last_cmd_printf("Unsupported event id '%s'\n", buf);
+
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret ?: nbytes;
+}
+
 int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
 				 struct seq_file *s, void *v)
 {
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 1bd61ed..20c898f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -610,6 +610,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
+ssize_t rdtgroup_mba_mbps_event_write(struct kernfs_open_file *of,
+				      char *buf, size_t nbytes, loff_t off);
 int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
 				 struct seq_file *s, void *v);
 bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_ctrl_domain *d,
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6eb930b..6419e04 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1952,8 +1952,9 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mba_MBps_event",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
+		.write		= rdtgroup_mba_mbps_event_write,
 		.seq_show	= rdtgroup_mba_mbps_event_show,
 	},
 	{

