Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8B33A3097
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jun 2021 18:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhFJQ3k (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Jun 2021 12:29:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhFJQ3j (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Jun 2021 12:29:39 -0400
Date:   Thu, 10 Jun 2021 16:27:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623342462;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HeQByG8RpQ++WnUTSK2nC9PUxl8n/DOzzfm4V9ERr08=;
        b=Zxzfk85sz4YeymwQANqL2JPfI27kIYYaTArP0Lq6fFVTu2AzI/KvzGSLwF3YLafNhibKh+
        EcdK2LHZiBJZssxWUkxsnuwnU269FJqvnkdmdE1DTwUWVBdfvUnOgtPQO6uCwMwhk/Upgu
        wmyE6NuYXQpIqxEa9NaPELY+kJBIX3Yjjcf1OpeeLGtL0R4Fg2BY//fQ6FTkihcRuQWW69
        I74zFe6n0mHeEeLoOEKPxwodIbNFP/XFAUfAnlmQ7GA3MwSyvAnbVyDcLIVz91b8NmS823
        Z76rDoaKzaEyU7sijJYpjmuXJ/ypVSBUZzJ+50eFesiDhyigh1g+Nf39+qrzeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623342462;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HeQByG8RpQ++WnUTSK2nC9PUxl8n/DOzzfm4V9ERr08=;
        b=RsBt+4Q6fAB3mMLu7QSl+DtPVB9C08EW8aUY/qkJxZhu6RlcX8+QoSauzX0FUGQs29pfcD
        6yL7pUg7leBmpdCQ==
From:   "tip-bot2 for Hubert Jasudowicz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] doc: Remove references to IBM Calgary
Cc:     Hubert Jasudowicz <hubert.jasudowicz@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C1bd2b57dd1db53df09e520b8170ff61418805de4=2E16232?=
 =?utf-8?q?74832=2Egit=2Ehubert=2Ejasudowicz=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C1bd2b57dd1db53df09e520b8170ff61418805de4=2E162327?=
 =?utf-8?q?4832=2Egit=2Ehubert=2Ejasudowicz=40gmail=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <162334246092.29796.9005969074055956442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     0e5a89dbb49920cea22193044bbbfd76a9b0f458
Gitweb:        https://git.kernel.org/tip/0e5a89dbb49920cea22193044bbbfd76a9b0f458
Author:        Hubert Jasudowicz <hubert.jasudowicz@gmail.com>
AuthorDate:    Wed, 09 Jun 2021 23:51:12 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Jun 2021 18:19:36 +02:00

doc: Remove references to IBM Calgary

The Calgary IOMMU driver has been removed in

  90dc392fc445 ("x86: Remove the calgary IOMMU driver")

Clean up stale docs that refer to it.

Signed-off-by: Hubert Jasudowicz <hubert.jasudowicz@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1bd2b57dd1db53df09e520b8170ff61418805de4.1623274832.git.hubert.jasudowicz@gmail.com
---
 Documentation/x86/x86_64/boot-options.rst | 31 +----------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index 324ceff..5f62b3b 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -247,16 +247,11 @@ Multiple x86-64 PCI-DMA mapping implementations exist, for example:
       Kernel boot message: "PCI-DMA: Using software bounce buffering
       for IO (SWIOTLB)"
 
-   4. <arch/x86_64/pci-calgary.c> : IBM Calgary hardware IOMMU. Used in IBM
-      pSeries and xSeries servers. This hardware IOMMU supports DMA address
-      mapping with memory protection, etc.
-      Kernel boot message: "PCI-DMA: Using Calgary IOMMU"
-
 ::
 
   iommu=[<size>][,noagp][,off][,force][,noforce]
   [,memaper[=<order>]][,merge][,fullflush][,nomerge]
-  [,noaperture][,calgary]
+  [,noaperture]
 
 General iommu options:
 
@@ -295,8 +290,6 @@ iommu options only relevant to the AMD GART hardware IOMMU:
       Don't initialize the AGP driver and use full aperture.
     panic
       Always panic when IOMMU overflows.
-    calgary
-      Use the Calgary IOMMU if it is available
 
 iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
 implementation:
@@ -307,28 +300,6 @@ implementation:
       force
         Force all IO through the software TLB.
 
-Settings for the IBM Calgary hardware IOMMU currently found in IBM
-pSeries and xSeries machines
-
-    calgary=[64k,128k,256k,512k,1M,2M,4M,8M]
-      Set the size of each PCI slot's translation table when using the
-      Calgary IOMMU. This is the size of the translation table itself
-      in main memory. The smallest table, 64k, covers an IO space of
-      32MB; the largest, 8MB table, can cover an IO space of 4GB.
-      Normally the kernel will make the right choice by itself.
-    calgary=[translate_empty_slots]
-      Enable translation even on slots that have no devices attached to
-      them, in case a device will be hotplugged in the future.
-    calgary=[disable=<PCI bus number>]
-      Disable translation on a given PHB. For
-      example, the built-in graphics adapter resides on the first bridge
-      (PCI bus number 0); if translation (isolation) is enabled on this
-      bridge, X servers that access the hardware directly from user
-      space might stop working. Use this option if you have devices that
-      are accessed from userspace directly on some PCI host bridge.
-    panic
-      Always panic when IOMMU overflows
-
 
 Miscellaneous
 =============
