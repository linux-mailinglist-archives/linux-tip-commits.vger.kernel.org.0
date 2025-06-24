Return-Path: <linux-tip-commits+bounces-5894-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1750EAE732F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 01:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0EB1BC2A53
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 23:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE17226B74F;
	Tue, 24 Jun 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2G9bo0GD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qBB1cTd9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B1D26B2DB;
	Tue, 24 Jun 2025 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807861; cv=none; b=SAcy/HLCOIHeLH1BrDRNHOPoFs68/3p9UCpeJ/7rqsFwX2IMgbuEImoSo1qEGfNcVMoMSh237/By5tdWUeseabp3z0hIvfIQjSYNIvikrjqvG/4wz8s6jpTWMwglaAHXpGa7fdxtI1wKZ3ksf3+w9EzNOcYhOhCFLvUKqKv5Xbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807861; c=relaxed/simple;
	bh=/D4USS01n3R5moh0OPALaT+5iwsJcUU3Ec+E8wI6zHs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=thRsFqVJp4zFMtxcbakqLBn/ZlX1TTuat3WbT8SLsurLdpGnl0+N9ssMjf2YEl8KPZoBPwsqtJmB5F/5JDdFK3F7JyAQqqcpx+dk/WillQqFf6PPxOFUoloq1t8Q/ru0sPisMfF5KatCiQhZx7q2MJ4u6VvOOZupnIdafqlSk84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2G9bo0GD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qBB1cTd9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Jun 2025 23:30:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750807857;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cHDUqV62bDpcdF6c9e2HdSJFdQi/C2FQyyOs8p+6N88=;
	b=2G9bo0GDxoYKkf9w6uJw+rRxUz1MRShXIEhlLhj2CiA01Agz9bwPV/rrsee8fe1y+G7HTK
	SlnAeSMPfGb2Oa+ZKF9UMwrpkK5YqMMyAoAB0AvIJH3xPGkauvIi9cHUg9zIhAG+Gc01XS
	d5b7aZbjqgiEIUfuTTqD4zBT5gilmkuPC7Sf8R1R3RhOLzZx7JNg8uyS6j2zGaVU4ZHosB
	o6JjUA7XNYIOz/rYXThUMhyjQoE08RkTBuWkugw3aTV3EfmdtVV0mwrgnDpB3AevV8ahtn
	zD8SQ6T/4Obqn+R8rCEg90lehlJw3+yUfraSQhkyPEcivBIEeQa1kUT+winMVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750807857;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cHDUqV62bDpcdF6c9e2HdSJFdQi/C2FQyyOs8p+6N88=;
	b=qBB1cTd9mBr1GFQ1Tts9IXxen9uzDC6WU+t2ieG0F3sH6frY/6CMmTVNTy0Bf6aAFT5kYB
	axO/WUqUR4VZrvDg==
From: "tip-bot2 for Yang Weijiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] x86/fpu/xstate: Introduce "guest-only" supervisor xfeature set
Cc: Chao Gao <chao.gao@intel.com>, Yang Weijiang <weijiang.yang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, John Allen <john.allen@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175080785696.406.5098775133998541975.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     151bf232494d7537e3d995b400e8233fd682ae1a
Gitweb:        https://git.kernel.org/tip/151bf232494d7537e3d995b400e8233fd682ae1a
Author:        Yang Weijiang <weijiang.yang@intel.com>
AuthorDate:    Thu, 22 May 2025 08:10:08 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 24 Jun 2025 13:46:32 -07:00

x86/fpu/xstate: Introduce "guest-only" supervisor xfeature set

In preparation for upcoming CET virtualization support, the CET supervisor
state will be added as a "guest-only" feature, since it is required only by
KVM (i.e., guest FPUs). Establish the infrastructure for "guest-only"
features.

Define a new XFEATURE_MASK_GUEST_SUPERVISOR mask to specify features that
are enabled by default in guest FPUs but not in host FPUs. Specifically,
for any bit in this set, permission is granted and XSAVE space is allocated
during vCPU creation. Non-guest FPUs cannot enable guest-only features,
even dynamically, and no XSAVE space will be allocated for them.

The mask is currently empty, but this will be changed by a subsequent
patch.

Co-developed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: John Allen <john.allen@amd.com>
Link: https://lore.kernel.org/all/20250522151031.426788-6-chao.gao%40intel.com
---
 arch/x86/include/asm/fpu/types.h  |  9 +++++----
 arch/x86/include/asm/fpu/xstate.h |  6 +++++-
 arch/x86/kernel/fpu/xstate.c      |  7 +++++--
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index abd193a..54ba567 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -592,8 +592,9 @@ struct fpu_state_config {
 	 * @default_size:
 	 *
 	 * The default size of the register state buffer. Includes all
-	 * supported features except independent managed features and
-	 * features which have to be requested by user space before usage.
+	 * supported features except independent managed features,
+	 * guest-only features and features which have to be requested by
+	 * user space before usage.
 	 */
 	unsigned int		default_size;
 
@@ -609,8 +610,8 @@ struct fpu_state_config {
 	 * @default_features:
 	 *
 	 * The default supported features bitmap. Does not include
-	 * independent managed features and features which have to
-	 * be requested by user space before usage.
+	 * independent managed features, guest-only features and features
+	 * which have to be requested by user space before usage.
 	 */
 	u64 default_features;
 	/*
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index b308a76..a3cd254 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -46,9 +46,13 @@
 /* Features which are dynamically enabled for a process on request */
 #define XFEATURE_MASK_USER_DYNAMIC	XFEATURE_MASK_XTILE_DATA
 
+/* Supervisor features which are enabled only in guest FPUs */
+#define XFEATURE_MASK_GUEST_SUPERVISOR	0
+
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID | \
-					    XFEATURE_MASK_CET_USER)
+					    XFEATURE_MASK_CET_USER | \
+					    XFEATURE_MASK_GUEST_SUPERVISOR)
 
 /*
  * A supervisor state component may not always contain valuable information,
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 7c5f9f1..d94a5f4 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -779,8 +779,11 @@ static void __init fpu__init_disable_system_xstate(unsigned int legacy_size)
 
 static u64 __init host_default_mask(void)
 {
-	/* Exclude dynamic features, which require userspace opt-in. */
-	return ~(u64)XFEATURE_MASK_USER_DYNAMIC;
+	/*
+	 * Exclude dynamic features (require userspace opt-in) and features
+	 * that are supported only for KVM guests.
+	 */
+	return ~((u64)XFEATURE_MASK_USER_DYNAMIC | XFEATURE_MASK_GUEST_SUPERVISOR);
 }
 
 static u64 __init guest_default_mask(void)

