Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0E9288232
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbgJIGfc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55382 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731940AbgJIGf2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:28 -0400
Date:   Fri, 09 Oct 2020 06:35:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GURDUJST2pgnaNGFSxbg04Ve9JGXN03mL1zzdKOGcBo=;
        b=YSGz88Lrwl4LpmaIuaui2kbq5Ww2z2ZzPtLdtJN9JlTsagsYvnZR0cSo7x+BhL+3y7NpCu
        LYTO8Z9QP7rX+nz5g3hDD6dDg8eDzDoJijLovFd/f4qDwOpoi9WsL9z/ZqaP98l1SKKm0y
        mogKIYEE9YIuMoENJVaDEomffegtPcY1AbJHI27QqOMLNLqkTkq4tsYnSQ9XG29gWBtkFx
        do+/370AEy3ow3uzWdmVwa0mZfID/XW4mIndp3ZZCrH7xrkiKxbSGfqVZExmQY1c+d0xsT
        ZgFjJu1AifFTtmkKVb0SH3egtkViQHmPfbnhnaeVUTcBYXguBMtzfg0wdLma2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GURDUJST2pgnaNGFSxbg04Ve9JGXN03mL1zzdKOGcBo=;
        b=sPB26GBbKv+IkRbenkVtvrCHxVDkL84LgbMOnHoY6RVyWAnZcQTa11QZXEs70Xf5DYNIzV
        if0k6cnlRkb/3EBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Block scftorture_invoker() kthreads for
 offline CPUs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532603.7002.481054098843056401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a7c072ef26644b632241d549869f10f8d2dd3b5c
Gitweb:        https://git.kernel.org/tip/a7c072ef26644b632241d549869f10f8d2dd3b5c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 02 Jul 2020 14:15:33 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:37 -07:00

scftorture: Block scftorture_invoker() kthreads for offline CPUs

Currently, CPU-hotplug operations might result in all but two
of (say) 100 CPUs being offline, which in turn might result in
false-positive diagnostics due to overload.  This commit therefore
causes scftorture_invoker() kthreads for offline CPUs to loop blocking
for 200 milliseconds at a time, thus continuously adjusting the number
of threads to match the number of online CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index d9c01c7..04d3a42 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -381,11 +381,14 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 // smp_call_function() family of functions.
 static int scftorture_invoker(void *arg)
 {
+	int cpu;
 	DEFINE_TORTURE_RANDOM(rand);
 	struct scf_statistics *scfp = (struct scf_statistics *)arg;
+	bool was_offline = false;
 
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d: task started", scfp->cpu);
-	set_cpus_allowed_ptr(current, cpumask_of(scfp->cpu % nr_cpu_ids));
+	cpu = scfp->cpu % nr_cpu_ids;
+	set_cpus_allowed_ptr(current, cpumask_of(cpu));
 	set_user_nice(current, MAX_NICE);
 	if (holdoff)
 		schedule_timeout_interruptible(holdoff * HZ);
@@ -408,6 +411,14 @@ static int scftorture_invoker(void *arg)
 
 	do {
 		scftorture_invoke_one(scfp, &rand);
+		while (cpu_is_offline(cpu) && !torture_must_stop()) {
+			schedule_timeout_interruptible(HZ / 5);
+			was_offline = true;
+		}
+		if (was_offline) {
+			set_cpus_allowed_ptr(current, cpumask_of(cpu));
+			was_offline = false;
+		}
 	} while (!torture_must_stop());
 
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d ended", scfp->cpu);
