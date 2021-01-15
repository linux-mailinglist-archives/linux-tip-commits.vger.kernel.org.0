Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12D42F73CE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Jan 2021 08:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbhAOHpm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Jan 2021 02:45:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36880 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbhAOHpm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Jan 2021 02:45:42 -0500
Date:   Fri, 15 Jan 2021 07:44:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610696699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NUVCFFOIyRNKJpFXgQ31TZ/+SHykmLpyx661cNquYeM=;
        b=EdwRY4I9/Ht/m74/0Fu6IyM8qMf01Q+2sXYOOsKBXcCvSI34uabWmN6VFK/J6AtHp77Z+a
        c4clXJmI+rrDohQ9Hu46YxAscRAZ2d8XAzQn9vtMk36R7v8PxqSOscBhCoWpBZFt79aSrX
        ibej8u9aVs92LBZH5wSmCwOdoxDAnj9b9d5iSCu9m/dhVKIy05cApA4REdnqSu0oU1cD/i
        pTt0Kxl9Mbw0kcQ1BmsQg2kdAdxqgeDuzLEWfVEhwmHh+jMIrE7bdwnxhwWCoCfSLb0LnO
        V6PluHj4JCxf7KZZOZbzzkwgeYtT+aDdHwFxFBfWQTsT5U0o5bsP0FDqi+fYng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610696699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NUVCFFOIyRNKJpFXgQ31TZ/+SHykmLpyx661cNquYeM=;
        b=JQVoLqS6a1lWLQLzsMc0+8try2CLmOnx+tbWjdOvue+pl/C1MxyKbpCfZSGE/2jIO+n0fb
        x9QEw/kqKa/JewDg==
From:   "tip-bot2 for Tom Rix" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Remove definition of DEBUG
Cc:     Tom Rix <trix@redhat.com>, Borislav Petkov <bp@suse.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210114212827.47584-1-trix@redhat.com>
References: <20210114212827.47584-1-trix@redhat.com>
MIME-Version: 1.0
Message-ID: <161069669846.414.838011020047246326.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b86cb29287be07041b81f5611e37ae9ffabff876
Gitweb:        https://git.kernel.org/tip/b86cb29287be07041b81f5611e37ae9ffabff876
Author:        Tom Rix <trix@redhat.com>
AuthorDate:    Thu, 14 Jan 2021 13:28:27 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 15 Jan 2021 08:23:10 +01:00

x86: Remove definition of DEBUG

Defining DEBUG should only be done in development. So remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20210114212827.47584-1-trix@redhat.com
---
 arch/x86/kernel/cpu/mtrr/generic.c | 1 -
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 2 --
 arch/x86/kernel/pci-iommu_table.c  | 3 ---
 arch/x86/mm/mmio-mod.c             | 2 --
 4 files changed, 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 23ad8e9..2cf4465 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -3,7 +3,6 @@
  * This only handles 32bit MTRR on 32bit hosts. This is strictly wrong
  * because MTRRs can span up to 40 bits (36bits on most modern x86)
  */
-#define DEBUG
 
 #include <linux/export.h>
 #include <linux/init.h>
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 61eb26e..28c8a23 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -31,8 +31,6 @@
     System Programming Guide; Section 9.11. (1997 edition - PPro).
 */
 
-#define DEBUG
-
 #include <linux/types.h> /* FIXME: kvm_para.h needs this */
 
 #include <linux/stop_machine.h>
diff --git a/arch/x86/kernel/pci-iommu_table.c b/arch/x86/kernel/pci-iommu_table.c
index 2e9006c..42e92ec 100644
--- a/arch/x86/kernel/pci-iommu_table.c
+++ b/arch/x86/kernel/pci-iommu_table.c
@@ -4,9 +4,6 @@
 #include <linux/string.h>
 #include <linux/kallsyms.h>
 
-
-#define DEBUG 1
-
 static struct iommu_table_entry * __init
 find_dependents_of(struct iommu_table_entry *start,
 		   struct iommu_table_entry *finish,
diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index bd7aff5..cd768da 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -10,8 +10,6 @@
 
 #define pr_fmt(fmt) "mmiotrace: " fmt
 
-#define DEBUG 1
-
 #include <linux/moduleparam.h>
 #include <linux/debugfs.h>
 #include <linux/slab.h>
