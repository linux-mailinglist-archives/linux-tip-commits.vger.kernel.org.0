Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8459F3B838B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbhF3Nt7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbhF3Nt4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:49:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2183CC061756;
        Wed, 30 Jun 2021 06:47:27 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=V48u48Boz5OYnVTueYq4sJCf9rHp9TWA8dzn96jykrI=;
        b=eBRgZgb2B0kOkBwjVzkokVplY61Lm0x78tvaZ1Q0nVU2UQZ9uZ/ATIsyfaja0Ys2ge1iWu
        cZfsC0zoY8hsH29FTvP8MQumZswgBq9dEiDpVt0BCSui7lBq+D0FjW4iehdDHje+/Ptzlr
        LsGGTBs5mqP7ImQzGa2CxVGo8g3/7APkCGVxMI7W0VUcPjv5myqcmMX2nMw8tEhVpWyfGd
        B8XWNrlS3SSLZlXR+H4vRtrNCrnoOqHfFB2eB16JXnqOGWn+JRTn3f7eLYgUwqfMxW2dVS
        XwYgl+gB6L8jR1XS6AsMz6Au4iWnOh9JAPgw/fy19DrGioY3x2KcDinr7/G9DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=V48u48Boz5OYnVTueYq4sJCf9rHp9TWA8dzn96jykrI=;
        b=FS8FaL9ZTbjxZxQUWBCG6zVVaG4hav2nioidjYoAFUrM/0Nh8sMMet3MC2Hlaf6scMFpke
        rHfq0V7HTIeqV9CA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Make ksoftirqd provide RCU Tasks quiescent states
Cc:     toke@redhat.com, Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506084384.395.12880210484179496851.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     cf868c2af244417ed276ba7f716b980841a71340
Gitweb:        https://git.kernel.org/tip/cf868c2af244417ed276ba7f716b980841a=
71340
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 24 Mar 2021 17:08:48 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 18 May 2021 10:54:51 -07:00

rcu-tasks: Make ksoftirqd provide RCU Tasks quiescent states

Heavy networking load can cause a CPU to execute continuously and
indefinitely within ksoftirqd, in which case there will be no voluntary
task switches and thus no RCU-tasks quiescent states.  This commit
therefore causes the exiting rcu_softirq_qs() to provide an RCU-tasks
quiescent state.

This of course means that __do_softirq() and its callers cannot be
invoked from within a tracing trampoline.

Reported-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e78b24..f4daa4e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -242,6 +242,7 @@ void rcu_softirq_qs(void)
 {
 	rcu_qs();
 	rcu_preempt_deferred_qs(current);
+	rcu_tasks_qs(current, false);
 }
=20
 /*
