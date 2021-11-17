Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18A4547FC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Nov 2021 15:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbhKQODp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Nov 2021 09:03:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60130 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbhKQODB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Nov 2021 09:03:01 -0500
Date:   Wed, 17 Nov 2021 14:00:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637157602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UeJ5Fv/o6sLgqS79q23ybkSeIg1C+KSuhPaYjwx/1W4=;
        b=jqudWlQGLCpfuLlwlUSKP0YVr3IihGCXsvg0xklLGyn6Ir3lbMBdNU8DLgEPrwfMFXg7oc
        HOk/+x6cPNo4kQr3W0MQX8UBqLpXXmK0yenrbfJpRuZPdBB2A37dWZ8VVAp33doOKO0w9U
        ZBtja6sjxkf+B0ps9OV0TXjmTFEG3hftxT3XErVEKvxTWHHFsScRybc9oE4fztoGKb7JWF
        /Tt1m/R36aG5JpJIC+O/CmzvMsq70g2HNZOGjRjTC+d4w+XPekBh5ZJTkze3vgDv0xGYBr
        oD+tzaWJvYcHTyAaPKq0NSRjxox6SOfutcqSdisViAwyHSoWx/e/bA4+GP8noA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637157602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UeJ5Fv/o6sLgqS79q23ybkSeIg1C+KSuhPaYjwx/1W4=;
        b=QxmL/JtH+IQfnrF6wyE5TcSAYngV/4uvJZD2kjBI0YNOT+j0dG/BSrdMtKAyN8S7JT6hTI
        e0KwIkX6bS68TzDg==
From:   "tip-bot2 for Liu Xinpeng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Add a missing SPDX license header
Cc:     Liu Xinpeng <liuxp11@chinatelecom.cn>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1635133586-84611-2-git-send-email-liuxp11@chinatelecom.cn>
References: <1635133586-84611-2-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Message-ID: <163715760108.11128.13626730380584820433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2fb75e1b642f49253d8848c9e47e8942f5366221
Gitweb:        https://git.kernel.org/tip/2fb75e1b642f49253d8848c9e47e8942f5366221
Author:        Liu Xinpeng <liuxp11@chinatelecom.cn>
AuthorDate:    Mon, 25 Oct 2021 11:46:26 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:48:59 +01:00

psi: Add a missing SPDX license header

Add the missing SPDX license header to
include/linux/psi.h
include/linux/psi_types.h
kernel/sched/psi.c

Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/r/1635133586-84611-2-git-send-email-liuxp11@chinatelecom.cn
---
 include/linux/psi.h       | 1 +
 include/linux/psi_types.h | 1 +
 kernel/sched/psi.c        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 65eb147..a70ca83 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_PSI_H
 #define _LINUX_PSI_H
 
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 0a23300..bf50068 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_PSI_TYPES_H
 #define _LINUX_PSI_TYPES_H
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 526af84..3397fa0 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Pressure stall information for CPU, memory and IO
  *
