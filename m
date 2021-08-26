Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885A33F83F4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 10:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhHZIxj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 04:53:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59004 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhHZIxi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 04:53:38 -0400
Date:   Thu, 26 Aug 2021 08:52:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629967970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6Xt6Przfl6hLW/hd9jDL1kMMgFq98n0E9M1rqxXnm2o=;
        b=iRpdAheCxMXmuBpHI9P51C0bjT8FijeuUoBs7WGrPAwBg7fFOREQvtBUPdo7Gcl6VZkrvt
        qi8rZOSu6Fxv4Uz7mPC6krkVGzIQUXdXza1L4SjaCffLNj5zYotOB5PXBq/aKoFxgboYBY
        zYH1g9ZXUp8ZHDQaFcxr1QipuPGPoZNsDAOZPm2Hv6eCYYp6M+lVZ3DLIXI7RHbXPDwhvT
        0UQSLnaps2a1L8hlT8escAMd0mx8TbUTZGV+Y7viRIx7tDtJbLULKhB8wrkS6I1cj4ldFU
        YFroLlcDMTsFsb2/ccSs5nu9uFyQz+Zok4ge6GRH7J2x+tLvNLYHZN2it0io+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629967970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6Xt6Przfl6hLW/hd9jDL1kMMgFq98n0E9M1rqxXnm2o=;
        b=+TENeSKatgsf9HrmF/EOLGvlrzcjKKZ17Pzk+DCOFxKwzDlTuT/9kzmB1fT3Oy3uHOWPhJ
        SiNftDzf4bgyIKBA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Mark tg_is_idle() an inline in the
 !CONFIG_FAIR_GROUP_SCHED case
Cc:     Ingo Molnar <mingo@kernel.org>, Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162996796861.25758.17874636915047083802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     366e7ad6ba5f4cb2ffd0b7316e404d6ee9c0f401
Gitweb:        https://git.kernel.org/tip/366e7ad6ba5f4cb2ffd0b7316e404d6ee9c=
0f401
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 26 Aug 2021 10:47:09 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Aug 2021 10:49:24 +02:00

sched/fair: Mark tg_is_idle() an inline in the !CONFIG_FAIR_GROUP_SCHED case

It's not actually used in the !CONFIG_FAIR_GROUP_SCHED case:

  kernel/sched/fair.c:488:12: warning: =E2=80=98tg_is_idle=E2=80=99 defined b=
ut not used [-Wunused-function]

Keep around a placeholder nevertheless, for API completeness. Mark it inline,
so the compiler doesn't think it must be used.

Fixes: 304000390f88: ("sched: Cgroup SCHED_IDLE support")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Josh Don <joshdon@google.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6cd05f1..7b3e859 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -485,7 +485,7 @@ find_matching_se(struct sched_entity **se, struct sched_e=
ntity **pse)
 {
 }
=20
-static int tg_is_idle(struct task_group *tg)
+static inline int tg_is_idle(struct task_group *tg)
 {
 	return 0;
 }
