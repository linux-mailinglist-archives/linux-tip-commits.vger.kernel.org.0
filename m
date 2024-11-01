Return-Path: <linux-tip-commits+bounces-2690-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459099B96D8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Nov 2024 18:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0111F2290B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Nov 2024 17:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA211CCEED;
	Fri,  1 Nov 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MdxOnaeY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KU6NmAKk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61051CDA14;
	Fri,  1 Nov 2024 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483411; cv=none; b=QMTBTFt2QFIKYUBctKIKkTmmqJy1fhPWWlPD0VPDtjTF9l9MDGOq+FpwefjMVW9P8fMWEXUxxkIYryB3GFpwdDEP3t/vG4X0ZGDm8VjD+IP1YZYTEXQ1m+gRlrqLyesLuezvMUPGaV1XEPf67nb0fPNoNfI7q6yY8Czo5CASunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483411; c=relaxed/simple;
	bh=1ZNHizq8Z6nKtubj+fm3UVJG60y/zHcADcUMQ6Qtbtc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=J1QpejQBHfH+jsboKeM0hU//0p4cN4Mfm5Lg13aGM513YUTL/POVrO6saM71P9JeKRJ55fuz98JfvHZUiLdctQq5/8a8eKapwGwiu0zkn1JBX3Qq6jTzuwYh+TylgPNpP8VIuKLH+YLboBFAzaZReQYCeW7azEY/oymTxON6QH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MdxOnaeY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KU6NmAKk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Nov 2024 17:50:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730483406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=c0c/5i96tQ/c7nEr/331iCf76t8qZk6T94EaAHkxVBc=;
	b=MdxOnaeY9zyyYtzRoB6fKmKhIxkreupnFcaCKvgyXMC5ear1YtMDw/FWzt8XiGCfgexRzm
	Gm2UXByphFyDoSZfU5I9I6xpxGO8kBRtosdaj8zpIS5wBM1pOblpwTCmN/Cv4BliGUirVS
	hnn8RcJ4BPQKp0yDFubni2Tq2SKkl8AaonRM/i5XeSYpakN6xh4tkNBB3p/PKQTorYSrNi
	ZIRIhs8DwJHhlqgw6mGXKdPX0W8Q2CPRYmWxxVUQ7W+Hfw8JNn5JPueE0VsbaZlTAn8MVR
	HDHUR/OEwPr8GyN5IEqNqfRwVMxH2w4ZmoyoTAX8tvW713bdy8/jc+1xoGC4Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730483406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=c0c/5i96tQ/c7nEr/331iCf76t8qZk6T94EaAHkxVBc=;
	b=KU6NmAKkHeTGL/nEgIDHF9/ZbnyZHYo5zaLWJ2I+t7n+hPdJEAa58MfcVlnlzxtXmPMAKW
	20d85pzn1uqqwqAA==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/mm/doc: Add missing details in virtual memory layout
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173048340553.3137.14329430184400702450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     035c5e2143f3edceeede1e99ff9cf8979c548dd5
Gitweb:        https://git.kernel.org/tip/035c5e2143f3edceeede1e99ff9cf8979c548dd5
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Thu, 31 Oct 2024 10:49:46 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 01 Nov 2024 10:38:06 -07:00

x86/mm/doc: Add missing details in virtual memory layout

Improve memory layout documentation:

 - Document 4kB guard hole at the end of userspace.
   See TASK_SIZE_MAX definition.

 - Divide the description of the non-canonical hole into two parts:
   userspace and kernel sides.

 - Mention the effect of LAM on the non-canonical range.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20241031084946.2243440-1-kirill.shutemov%40linux.intel.com
---
 Documentation/arch/x86/x86_64/mm.rst | 35 ++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/x86/x86_64/mm.rst b/Documentation/arch/x86/x86_64/mm.rst
index 35e5e18..f2db178 100644
--- a/Documentation/arch/x86/x86_64/mm.rst
+++ b/Documentation/arch/x86/x86_64/mm.rst
@@ -29,15 +29,27 @@ Complete virtual memory map with 4-level page tables
       Start addr    |   Offset   |     End addr     |  Size   | VM area description
   ========================================================================================================================
                     |            |                  |         |
-   0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space virtual memory, different per mm
+   0000000000000000 |    0       | 00007fffffffefff | ~128 TB | user-space virtual memory, different per mm
+   00007ffffffff000 | ~128    TB | 00007fffffffffff |    4 kB | ... guard hole
   __________________|____________|__________________|_________|___________________________________________________________
                     |            |                  |         |
-   0000800000000000 | +128    TB | ffff7fffffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical
-                    |            |                  |         |     virtual memory addresses up to the -128 TB
+   0000800000000000 | +128    TB | 7fffffffffffffff |   ~8 EB | ... huge, almost 63 bits wide hole of non-canonical
+                    |            |                  |         |     virtual memory addresses up to the -8 EB
                     |            |                  |         |     starting offset of kernel mappings.
+                    |            |                  |         |
+                    |            |                  |         | LAM relaxes canonicallity check allowing to create aliases
+                    |            |                  |         | for userspace memory here.
   __________________|____________|__________________|_________|___________________________________________________________
                                                               |
                                                               | Kernel-space virtual memory, shared between all processes:
+  __________________|____________|__________________|_________|___________________________________________________________
+                    |            |                  |         |
+   8000000000000000 |   -8    EB | ffff7fffffffffff |   ~8 EB | ... huge, almost 63 bits wide hole of non-canonical
+                    |            |                  |         |     virtual memory addresses up to the -128 TB
+                    |            |                  |         |     starting offset of kernel mappings.
+                    |            |                  |         |
+                    |            |                  |         | LAM_SUP relaxes canonicallity check allowing to create
+                    |            |                  |         | aliases for kernel memory here.
   ____________________________________________________________|___________________________________________________________
                     |            |                  |         |
    ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor
@@ -88,16 +100,27 @@ Complete virtual memory map with 5-level page tables
       Start addr    |   Offset   |     End addr     |  Size   | VM area description
   ========================================================================================================================
                     |            |                  |         |
-   0000000000000000 |    0       | 00ffffffffffffff |   64 PB | user-space virtual memory, different per mm
+   0000000000000000 |    0       | 00fffffffffff000 |  ~64 PB | user-space virtual memory, different per mm
+   00fffffffffff000 |  ~64    PB | 00ffffffffffffff |    4 kB | ... guard hole
   __________________|____________|__________________|_________|___________________________________________________________
                     |            |                  |         |
-   0100000000000000 |  +64    PB | feffffffffffffff | ~16K PB | ... huge, still almost 64 bits wide hole of non-canonical
-                    |            |                  |         |     virtual memory addresses up to the -64 PB
+   0100000000000000 |  +64    PB | 7fffffffffffffff |   ~8 EB | ... huge, almost 63 bits wide hole of non-canonical
+                    |            |                  |         |     virtual memory addresses up to the -8EB TB
                     |            |                  |         |     starting offset of kernel mappings.
+                    |            |                  |         |
+                    |            |                  |         | LAM relaxes canonicallity check allowing to create aliases
+                    |            |                  |         | for userspace memory here.
   __________________|____________|__________________|_________|___________________________________________________________
                                                               |
                                                               | Kernel-space virtual memory, shared between all processes:
   ____________________________________________________________|___________________________________________________________
+   8000000000000000 |   -8    EB | feffffffffffffff |   ~8 EB | ... huge, almost 63 bits wide hole of non-canonical
+                    |            |                  |         |     virtual memory addresses up to the -64 PB
+                    |            |                  |         |     starting offset of kernel mappings.
+                    |            |                  |         |
+                    |            |                  |         | LAM_SUP relaxes canonicallity check allowing to create
+                    |            |                  |         | aliases for kernel memory here.
+  ____________________________________________________________|___________________________________________________________
                     |            |                  |         |
    ff00000000000000 |  -64    PB | ff0fffffffffffff |    4 PB | ... guard hole, also reserved for hypervisor
    ff10000000000000 |  -60    PB | ff10ffffffffffff | 0.25 PB | LDT remap for PTI

