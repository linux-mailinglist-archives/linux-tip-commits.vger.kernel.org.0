Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BBA25914B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Sep 2020 16:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgIAOtX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Sep 2020 10:49:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39444 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgIALs2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:28 -0400
Date:   Tue, 01 Sep 2020 11:47:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960875;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6H7pYz/RFeshDuKqJ0FUSS9Irmz7kYYz+37l6Oei5ow=;
        b=R0HVw9LxkjIRBtXJElIuI12FZ5TI+tLD3drCGmXpty5c85zS/s6xrsD9S04Vof/kTRAvyc
        hJ1Pv7aRvrJj9K3K7zUlM6V9CzwPMKMmXnFE2oQPBmt8qlk2tRYp3L3popuJxTbNrZci+H
        Q3YXVaT09fy5/Y8jjIAnN0SIzMf1uOMqBOUOeUwrrQE9tYRuUEkL31XbYxDR6KJj69tYWm
        WtrjxF5YGqNTumRFYyOVAgbDqAFMjSybb5RKrfa/mtPH0NFlzASFgrQ2yLhfb7Io7Ez/+R
        ZkJz60yHOGAWFMdntmG2QKmeL9TAuis7M52vDZ3AEwiFeR9OxPUw/hFGRH48aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960875;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6H7pYz/RFeshDuKqJ0FUSS9Irmz7kYYz+37l6Oei5ow=;
        b=YH9xp/eQviAl5DtSeffSdqIQQuS5mdyjK0ko70sJENMUin5vsmSqhZSeIjxfvVlpxIDG69
        2/GJyUzOlrGra1AA==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] arm/build: Assert for unwanted sections
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Russell King <linux@armlinux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-19-keescook@chromium.org>
References: <20200821194310.3089815-19-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087511.20229.3683531986832107213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     0c918e753f8c03b0308a635c0721a8c24d738d4a
Gitweb:        https://git.kernel.org/tip/0c918e753f8c03b0308a635c0721a8c24d738d4a
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:42:59 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 10:03:18 +02:00

arm/build: Assert for unwanted sections

In preparation for warning on orphan sections, enforce
expected-to-be-zero-sized sections (since discarding them might hide
problems with them suddenly gaining unexpected entries).

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Link: https://lore.kernel.org/r/20200821194310.3089815-19-keescook@chromium.org
---
 arch/arm/include/asm/vmlinux.lds.h | 11 +++++++++++
 arch/arm/kernel/vmlinux-xip.lds.S  |  2 ++
 arch/arm/kernel/vmlinux.lds.S      |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index 6624dd9..4a91428 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -52,6 +52,17 @@
 		ARM_MMU_DISCARD(*(__ex_table))				\
 		COMMON_DISCARDS
 
+/*
+ * Sections that should stay zero sized, which is safer to explicitly
+ * check instead of blindly discarding.
+ */
+#define ARM_ASSERTS							\
+	.plt : {							\
+		*(.iplt) *(.rel.iplt) *(.iplt) *(.igot.plt)		\
+	}								\
+	ASSERT(SIZEOF(.plt) == 0,					\
+	       "Unexpected run-time procedure linkages detected!")
+
 #define ARM_DETAILS							\
 		ELF_DETAILS						\
 		.ARM.attributes 0 : { *(.ARM.attributes) }
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 11ffa79..5013682 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -152,6 +152,8 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 	ARM_DETAILS
+
+	ARM_ASSERTS
 }
 
 /*
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index dc672fe..5f4922e 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -151,6 +151,8 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 	ARM_DETAILS
+
+	ARM_ASSERTS
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
