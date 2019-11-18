Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56BEB1001E5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Nov 2019 10:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKRJ4I (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 18 Nov 2019 04:56:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49536 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKRJ4I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 18 Nov 2019 04:56:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iWdlL-0006Lz-5E; Mon, 18 Nov 2019 10:56:03 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C424F1C19B5;
        Mon, 18 Nov 2019 10:56:02 +0100 (CET)
Date:   Mon, 18 Nov 2019 09:56:02 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Remove unused asm/rio.h
Cc:     Jon Mason <jdmason@kudzu.us>, Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157407096266.12247.7738797017268106453.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b41d62201b9772c7c750360ab668d2caa502e642
Gitweb:        https://git.kernel.org/tip/b41d62201b9772c7c750360ab668d2caa502e642
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 18 Nov 2019 10:47:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 18 Nov 2019 10:52:11 +01:00

x86: Remove unused asm/rio.h

The removed calgary IOMMU driver was the only user of this header file.

Reported-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/x86/include/asm/rio.h | 64 +-------------------------------------
 1 file changed, 64 deletions(-)
 delete mode 100644 arch/x86/include/asm/rio.h

diff --git a/arch/x86/include/asm/rio.h b/arch/x86/include/asm/rio.h
deleted file mode 100644
index 0a21986..0000000
--- a/arch/x86/include/asm/rio.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Derived from include/asm-x86/mach-summit/mach_mpparse.h
- *          and include/asm-x86/mach-default/bios_ebda.h
- *
- * Author: Laurent Vivier <Laurent.Vivier@bull.net>
- */
-
-#ifndef _ASM_X86_RIO_H
-#define _ASM_X86_RIO_H
-
-#define RIO_TABLE_VERSION	3
-
-struct rio_table_hdr {
-	u8 version;		/* Version number of this data structure  */
-	u8 num_scal_dev;	/* # of Scalability devices               */
-	u8 num_rio_dev;		/* # of RIO I/O devices                   */
-} __attribute__((packed));
-
-struct scal_detail {
-	u8 node_id;		/* Scalability Node ID                    */
-	u32 CBAR;		/* Address of 1MB register space          */
-	u8 port0node;		/* Node ID port connected to: 0xFF=None   */
-	u8 port0port;		/* Port num port connected to: 0,1,2, or  */
-				/* 0xFF=None                              */
-	u8 port1node;		/* Node ID port connected to: 0xFF = None */
-	u8 port1port;		/* Port num port connected to: 0,1,2, or  */
-				/* 0xFF=None                              */
-	u8 port2node;		/* Node ID port connected to: 0xFF = None */
-	u8 port2port;		/* Port num port connected to: 0,1,2, or  */
-				/* 0xFF=None                              */
-	u8 chassis_num;		/* 1 based Chassis number (1 = boot node) */
-} __attribute__((packed));
-
-struct rio_detail {
-	u8 node_id;		/* RIO Node ID                            */
-	u32 BBAR;		/* Address of 1MB register space          */
-	u8 type;		/* Type of device                         */
-	u8 owner_id;		/* Node ID of Hurricane that owns this    */
-				/* node                                   */
-	u8 port0node;		/* Node ID port connected to: 0xFF=None   */
-	u8 port0port;		/* Port num port connected to: 0,1,2, or  */
-				/* 0xFF=None                              */
-	u8 port1node;		/* Node ID port connected to: 0xFF=None   */
-	u8 port1port;		/* Port num port connected to: 0,1,2, or  */
-				/* 0xFF=None                              */
-	u8 first_slot;		/* Lowest slot number below this Calgary  */
-	u8 status;		/* Bit 0 = 1 : the XAPIC is used          */
-				/*       = 0 : the XAPIC is not used, ie: */
-				/*            ints fwded to another XAPIC */
-				/*           Bits1:7 Reserved             */
-	u8 WP_index;		/* instance index - lower ones have       */
-				/*     lower slot numbers/PCI bus numbers */
-	u8 chassis_num;		/* 1 based Chassis number                 */
-} __attribute__((packed));
-
-enum {
-	HURR_SCALABILTY	= 0,	/* Hurricane Scalability info */
-	HURR_RIOIB	= 2,	/* Hurricane RIOIB info       */
-	COMPAT_CALGARY	= 4,	/* Compatibility Calgary      */
-	ALT_CALGARY	= 5,	/* Second Planar Calgary      */
-};
-
-#endif /* _ASM_X86_RIO_H */
