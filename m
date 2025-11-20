Return-Path: <linux-tip-commits+bounces-7432-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D617BC76108
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 20:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 356074E1D8B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 19:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF103446C2;
	Thu, 20 Nov 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h+f7KpNk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2iYcurj6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A26B2FD691;
	Thu, 20 Nov 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666578; cv=none; b=gmp+pFjL3Phqp32xQdlJXzqw/Y86JZvUhDjjoA8vz1hZD0tclIzIFilWyMpUBka064Me/t60fb3PN5YeetDW5p42uYcvk9a0pRTRveZzND8NUO4wyrWqG3R5xOb9cCnQmRLMt5dJcUCR6HAm9tNDM/7RTKprrOXEjbPb95EeIs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666578; c=relaxed/simple;
	bh=zGeOiOwOY2xI/mIDj2eJkQca0aeAqvp6AaI0UiHmcKE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a47T01kQDb2ZvQ9qgz+3nj9juR98dX4bhUYXnqj310sjQVqtESdKac8rbR6eNlLrlpI9Ib/A9A07NDRYSP5hxzTgr7VUZIJd9F6gDBjMd4zEhn4bYyt4Tzgf/Fnw/TbosWeEEL8pB24AUyJtMMKkcNVhJ2x7bciU54fsC/2Q3AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h+f7KpNk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2iYcurj6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 19:22:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763666575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7I1fIfcbR708zVsNi9Dl4oe3NdqMWEiJ0ing9hKpsY=;
	b=h+f7KpNkK01ScRYsqkI3MPihVy67hjk8HU3M/8iuI2IdHJsRO6itP7fttC3OdJQpwUq0y4
	M3h9VzN/EPgrZX/vQXfQtwZ/2K6sOdUn2Mw/JpZBQDfSBo0OIRqUjKs41n8Htu/HGOpj18
	sVpiYaOrw+8Oy6dqFWIan0KOhJ2bJSFzqGW0cX+ypl6V0j/c35iXoTq5/QV3EPwoOzMCAO
	xwUG9Fl1sr5IkzcBsGp4dSsCE9AVt9A5tPG/EZDLwsJE7KrPslhug+4GI7FPxkIGkcIcu6
	zKJMEXzha/uosCzCFQInsHsJZLJwE+gs+YMRxUsAUkj0gfpcUto8I+/njMZ0wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763666575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7I1fIfcbR708zVsNi9Dl4oe3NdqMWEiJ0ing9hKpsY=;
	b=2iYcurj61/M1R0XB+biJXmQ98iD6HBc6z1sjy5FjLPnHaaFTIKoj/sVS+DclApNsQsjvBU
	eJHEWc5AjAEn8hCQ==
From: "tip-bot2 for Gabriele Monaco" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] cgroup/cpuset: Rename
 update_unbound_workqueue_cpumask() to update_isolation_cpumasks()
Cc: Gabriele Monaco <gmonaco@redhat.com>, Waiman Long <longman@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Chen Ridong <chenridong@huaweicloud.com>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251120145653.296659-5-gmonaco@redhat.com>
References: <20251120145653.296659-5-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176366657424.498.6612718756429072696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     22f8e41680efec63ead03d4693676587814f7a24
Gitweb:        https://git.kernel.org/tip/22f8e41680efec63ead03d4693676587814=
f7a24
Author:        Gabriele Monaco <gmonaco@redhat.com>
AuthorDate:    Thu, 20 Nov 2025 15:56:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Nov 2025 20:17:31 +01:00

cgroup/cpuset: Rename update_unbound_workqueue_cpumask() to update_isolation_=
cpumasks()

update_unbound_workqueue_cpumask() updates unbound workqueues settings
when there's a change in isolated CPUs, but it can be used for other
subsystems requiring updated when isolated CPUs change.

Generalise the name to update_isolation_cpumasks() to prepare for other
functions unrelated to workqueues to be called in that spot.

[longman: Change the function name to update_isolation_cpumasks()]

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://patch.msgid.link/20251120145653.296659-5-gmonaco@redhat.com
---
 kernel/cgroup/cpuset.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 27adb04..cf34623 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1339,7 +1339,7 @@ static bool partition_xcpus_del(int old_prs, struct cpu=
set *parent,
 	return isolcpus_updated;
 }
=20
-static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
+static void update_isolation_cpumasks(bool isolcpus_updated)
 {
 	int ret;
=20
@@ -1470,7 +1470,7 @@ static int remote_partition_enable(struct cpuset *cs, i=
nt new_prs,
 	list_add(&cs->remote_sibling, &remote_children);
 	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 	cpuset_force_rebuild();
 	cs->prs_err =3D 0;
=20
@@ -1511,7 +1511,7 @@ static void remote_partition_disable(struct cpuset *cs,=
 struct tmpmasks *tmp)
 	compute_effective_exclusive_cpumask(cs, NULL, NULL);
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 	cpuset_force_rebuild();
=20
 	/*
@@ -1580,7 +1580,7 @@ static void remote_cpus_update(struct cpuset *cs, struc=
t cpumask *xcpus,
 	if (xcpus)
 		cpumask_copy(cs->exclusive_cpus, xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
 	if (adding || deleting)
 		cpuset_force_rebuild();
=20
@@ -1943,7 +1943,7 @@ write_error:
 		WARN_ON_ONCE(parent->nr_subparts < 0);
 	}
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
=20
 	if ((old_prs !=3D new_prs) && (cmd =3D=3D partcmd_update))
 		update_partition_exclusive_flag(cs, new_prs);
@@ -2968,7 +2968,7 @@ out:
 	else if (isolcpus_updated)
 		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_isolation_cpumasks(isolcpus_updated);
=20
 	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);

