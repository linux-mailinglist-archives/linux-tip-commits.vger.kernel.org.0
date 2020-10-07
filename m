Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90C7285912
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 09:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgJGHME (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 03:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbgJGHME (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 03:12:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F06C0613D2;
        Wed,  7 Oct 2020 00:12:03 -0700 (PDT)
Date:   Wed, 07 Oct 2020 07:11:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602054721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GuZ53hlB0u4JMlTc+MMPIfOPx3IkGjSvbNx4A0N8hJ0=;
        b=D1p/HY1f8zRPoGHSafeDaJY6aRdremvqZ3P+0AvDzEtQAPXQh+OivSevQvqmOXuka6vVOt
        VEerDMPR7FMb9kNyfekmYRl0sFefUTPXnnXIvA4rAwqy6O21FY7H7d6mrYd+2bAyY/lhAs
        qPiQNPMzW90+wLQvQU8eSdAp6/q9oa8DndaVWSQ7sYPACJKb3TQd6fcwW+OG33VBPaA360
        DTBWd7V7CZEqT+xGOd941HBlhk0Rog0Z3O/nPRus6pZ37yWNXdKSJxvGmH1FIlmM3vdpjU
        9Nll0lBspiq6NtK6FbI3izjPelAklFCQkhkbeB5T3Ndoj2vsWNPtIiAJDBI0Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602054721;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GuZ53hlB0u4JMlTc+MMPIfOPx3IkGjSvbNx4A0N8hJ0=;
        b=pdT03fZWgp3aGHFain9O5Muta0nkEObSRg6v189zqrh/x++6O00tgrn6vwT3buuHX5rpnM
        OnTS06X+CH/u9uDw==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Update Copyrights to conform to
 HPE standards
Cc:     Mike Travis <mike.travis@hpe.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201005203929.148656-14-mike.travis@hpe.com>
References: <20201005203929.148656-14-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160205471979.7002.3316317527044547703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     7a6d94f0ed957fb667d4d74c5c6c640a26e87c8f
Gitweb:        https://git.kernel.org/tip/7a6d94f0ed957fb667d4d74c5c6c640a26e87c8f
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Mon, 05 Oct 2020 15:39:29 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 09:10:07 +02:00

x86/platform/uv: Update Copyrights to conform to HPE standards

Add Copyrights to those files that have been updated for UV5 changes.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201005203929.148656-14-mike.travis@hpe.com
---
 arch/x86/include/asm/uv/bios.h      | 1 +
 arch/x86/include/asm/uv/uv_hub.h    | 1 +
 arch/x86/include/asm/uv/uv_mmrs.h   | 1 +
 arch/x86/kernel/apic/x2apic_uv_x.c  | 1 +
 arch/x86/platform/uv/bios_uv.c      | 1 +
 arch/x86/platform/uv/uv_nmi.c       | 1 +
 arch/x86/platform/uv/uv_time.c      | 1 +
 drivers/misc/sgi-gru/grufile.c      | 1 +
 drivers/misc/sgi-xp/xp.h            | 1 +
 drivers/misc/sgi-xp/xp_main.c       | 1 +
 drivers/misc/sgi-xp/xp_uv.c         | 1 +
 drivers/misc/sgi-xp/xpc_main.c      | 1 +
 drivers/misc/sgi-xp/xpc_partition.c | 1 +
 drivers/misc/sgi-xp/xpnet.c         | 1 +
 14 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index 97ac595..08b3d81 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -5,6 +5,7 @@
 /*
  * UV BIOS layer definitions.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
  * Copyright (c) Russ Anderson <rja@sgi.com>
  */
diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 610bda2..5002f52 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -5,6 +5,7 @@
  *
  * SGI UV architectural definitions
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 2007-2014 Silicon Graphics, Inc. All rights reserved.
  */
 
diff --git a/arch/x86/include/asm/uv/uv_mmrs.h b/arch/x86/include/asm/uv/uv_mmrs.h
index 06ea2d1..57fa673 100644
--- a/arch/x86/include/asm/uv/uv_mmrs.h
+++ b/arch/x86/include/asm/uv/uv_mmrs.h
@@ -5,6 +5,7 @@
  *
  * HPE UV MMR definitions
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 2007-2016 Silicon Graphics, Inc. All rights reserved.
  */
 
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 9a83aa1..714233c 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -5,6 +5,7 @@
  *
  * SGI UV APIC functions (note: not an Intel compatible APIC)
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 2007-2014 Silicon Graphics, Inc. All rights reserved.
  */
 #include <linux/crash_dump.h>
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index b148b4c..54511ea 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -2,6 +2,7 @@
 /*
  * BIOS run time interface routines.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
  * Copyright (c) Russ Anderson <rja@sgi.com>
  */
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index eac26fe..0f5cbcf 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -2,6 +2,7 @@
 /*
  * SGI NMI support routines
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
  * Copyright (c) Mike Travis
  */
diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index d996735..54663f3 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -2,6 +2,7 @@
 /*
  * SGI RTC clock/timer routines.
  *
+ *  (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  *  Copyright (c) 2009-2013 Silicon Graphics, Inc.  All Rights Reserved.
  *  Copyright (c) Dimitri Sivanich
  */
diff --git a/drivers/misc/sgi-gru/grufile.c b/drivers/misc/sgi-gru/grufile.c
index 18aa8c8..7ffcfc0 100644
--- a/drivers/misc/sgi-gru/grufile.c
+++ b/drivers/misc/sgi-gru/grufile.c
@@ -7,6 +7,7 @@
  * This file supports the user system call for file open, close, mmap, etc.
  * This also incudes the driver initialization code.
  *
+ *  (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  *  Copyright (c) 2008-2014 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
diff --git a/drivers/misc/sgi-xp/xp.h b/drivers/misc/sgi-xp/xp.h
index 2b6aabc..9f9af77 100644
--- a/drivers/misc/sgi-xp/xp.h
+++ b/drivers/misc/sgi-xp/xp.h
@@ -3,6 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 2004-2008 Silicon Graphics, Inc. All rights reserved.
  */
 
diff --git a/drivers/misc/sgi-xp/xp_main.c b/drivers/misc/sgi-xp/xp_main.c
index 0eea2f5..cf2965a 100644
--- a/drivers/misc/sgi-xp/xp_main.c
+++ b/drivers/misc/sgi-xp/xp_main.c
@@ -3,6 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (c) 2004-2008 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
diff --git a/drivers/misc/sgi-xp/xp_uv.c b/drivers/misc/sgi-xp/xp_uv.c
index 5dcca03..19fc707 100644
--- a/drivers/misc/sgi-xp/xp_uv.c
+++ b/drivers/misc/sgi-xp/xp_uv.c
@@ -3,6 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (c) 2008 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
diff --git a/drivers/misc/sgi-xp/xpc_main.c b/drivers/misc/sgi-xp/xpc_main.c
index e3261e6..e5244fc 100644
--- a/drivers/misc/sgi-xp/xpc_main.c
+++ b/drivers/misc/sgi-xp/xpc_main.c
@@ -3,6 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (c) 2004-2009 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
diff --git a/drivers/misc/sgi-xp/xpc_partition.c b/drivers/misc/sgi-xp/xpc_partition.c
index a47b3bd..57df068 100644
--- a/drivers/misc/sgi-xp/xpc_partition.c
+++ b/drivers/misc/sgi-xp/xpc_partition.c
@@ -3,6 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (c) 2004-2008 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
diff --git a/drivers/misc/sgi-xp/xpnet.c b/drivers/misc/sgi-xp/xpnet.c
index 8ee3991..23837d0 100644
--- a/drivers/misc/sgi-xp/xpnet.c
+++ b/drivers/misc/sgi-xp/xpnet.c
@@ -3,6 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
+ * (C) Copyright 2020 Hewlett Packard Enterprise Development LP
  * Copyright (C) 1999-2009 Silicon Graphics, Inc. All rights reserved.
  */
 
