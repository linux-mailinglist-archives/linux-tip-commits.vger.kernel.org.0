Return-Path: <linux-tip-commits+bounces-1282-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A6F8CBC31
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 May 2024 09:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81912B21527
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 May 2024 07:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC583BBC9;
	Wed, 22 May 2024 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bZt7NAqb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wNt1EplU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AEAB65E;
	Wed, 22 May 2024 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363742; cv=none; b=UrRkVqcK8i8+lHozu/QJoHEX9j6bykVZ3tyBdjTXaTTHDaxQlkJHO5bXABwR2HBuTySDAlR7Jl2kJvbXQTOmk9RDLtwbVd2LD4NvB/FAH5RbMwQwDFSLEHKg3R0v6YJge8XjRPVfUh+zjrYGBnFTafqNYvIyUOMgiChrxwC9/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363742; c=relaxed/simple;
	bh=rxKN71VpGxYtjkgxNReprJSlk2dzVEoZhuFNDMk6Wxc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=PYVC0bhwl6jkHMZZWaCoo8H7whWxK21Dm8xJticBwwy3NysvsIUfh554CxwZPFGn0yMupAA0RnYlGEgqDdV+zF46Q0khqvB+MWS2Hgo2rJIsP6iZ3QB/JSVC8Sz14q4PSiVnc57mOSAKGX7k2Aby+ZO/vjC0vlYHWTsB872Q4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bZt7NAqb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wNt1EplU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 22 May 2024 07:42:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716363737;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=/S8FV9j2oiYN4vc8M28HvM1rkdMF6GJRTY8GZcK8n0I=;
	b=bZt7NAqbECp/PnWzUob6TL/gKv8Z8YuJNkRVrZn6gWaj9NTMzINmp/Zc/DITrxgyARFXGf
	0M4/4LY42mzumSQwp37zl42ulr8oyGeX/Egw0B4TiABQrfdUzvCJY7lqINNIeAh/UdRqsp
	xRpsmjSOfI95jP6joHnYgJ36dgNvAlDwu6qAmRESQXL6CKtavCqTTge7Sa0YKWHY7GRNmh
	LCX2QG/KzJHyDlYrSOH6FpMS/hO9Q2GFWCKCOastOt8Irv8kpA6NM/iaN6crAfIRV67thv
	xFeHzREt65Af/Lw5cz8sirKywPTAwkXWGy1/2+bhrJMxuizWKUmnGeFvdUFo4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716363737;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=/S8FV9j2oiYN4vc8M28HvM1rkdMF6GJRTY8GZcK8n0I=;
	b=wNt1EplUUBjWYO7LdjcO0vAKaXt+wrLnQ790VrXMrSCCHKlmFkRJr22h+GwnBOIr+Jl4gL
	/PNbf3iXAbvyENCA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/boot: Clean up the arch/x86/boot/main.c code a bit
Cc: Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171636373729.10875.4887706398268223159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     52cccc64cf7c90696d09d54a383793804ba872ba
Gitweb:        https://git.kernel.org/tip/52cccc64cf7c90696d09d54a383793804ba872ba
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 21 May 2024 13:42:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 May 2024 09:36:49 +02:00

x86/boot: Clean up the arch/x86/boot/main.c code a bit

 - Don't line break user-visible strings

 - Use consistent comment style

 - Remove unnecessary col80 line breaks

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/boot/main.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index ac78f8c..9d0fea1 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -27,34 +27,32 @@ char *heap_end = _end;		/* Default end of heap = no heap */
  * screws up the old-style command line protocol, adjust by
  * filling in the new-style command line pointer instead.
  */
-
 static void copy_boot_params(void)
 {
 	struct old_cmdline {
 		u16 cl_magic;
 		u16 cl_offset;
 	};
-	const struct old_cmdline * const oldcmd =
-		absolute_pointer(OLD_CL_ADDRESS);
+	const struct old_cmdline * const oldcmd = absolute_pointer(OLD_CL_ADDRESS);
 
 	BUILD_BUG_ON(sizeof(boot_params) != 4096);
 	memcpy(&boot_params.hdr, &hdr, sizeof(hdr));
 
-	if (!boot_params.hdr.cmd_line_ptr &&
-	    oldcmd->cl_magic == OLD_CL_MAGIC) {
-		/* Old-style command line protocol. */
+	if (!boot_params.hdr.cmd_line_ptr && oldcmd->cl_magic == OLD_CL_MAGIC) {
+		/* Old-style command line protocol */
 		u16 cmdline_seg;
 
-		/* Figure out if the command line falls in the region
-		   of memory that an old kernel would have copied up
-		   to 0x90000... */
+		/*
+		 * Figure out if the command line falls in the region
+		 * of memory that an old kernel would have copied up
+		 * to 0x90000...
+		 */
 		if (oldcmd->cl_offset < boot_params.hdr.setup_move_size)
 			cmdline_seg = ds();
 		else
 			cmdline_seg = 0x9000;
 
-		boot_params.hdr.cmd_line_ptr =
-			(cmdline_seg << 4) + oldcmd->cl_offset;
+		boot_params.hdr.cmd_line_ptr = (cmdline_seg << 4) + oldcmd->cl_offset;
 	}
 }
 
@@ -66,6 +64,7 @@ static void copy_boot_params(void)
 static void keyboard_init(void)
 {
 	struct biosregs ireg, oreg;
+
 	initregs(&ireg);
 
 	ireg.ah = 0x02;		/* Get keyboard status */
@@ -83,8 +82,10 @@ static void query_ist(void)
 {
 	struct biosregs ireg, oreg;
 
-	/* Some older BIOSes apparently crash on this call, so filter
-	   it from machines too old to have SpeedStep at all. */
+	/*
+	 * Some older BIOSes apparently crash on this call, so filter
+	 * it from machines too old to have SpeedStep at all.
+	 */
 	if (cpu.level < 6)
 		return;
 
@@ -119,16 +120,13 @@ static void init_heap(void)
 	char *stack_end;
 
 	if (boot_params.hdr.loadflags & CAN_USE_HEAP) {
-		stack_end = (char *)
-			(current_stack_pointer - STACK_SIZE);
-		heap_end = (char *)
-			((size_t)boot_params.hdr.heap_end_ptr + 0x200);
+		stack_end = (char *) (current_stack_pointer - STACK_SIZE);
+		heap_end = (char *) ((size_t)boot_params.hdr.heap_end_ptr + 0x200);
 		if (heap_end > stack_end)
 			heap_end = stack_end;
 	} else {
 		/* Boot protocol 2.00 only, no heap available */
-		puts("WARNING: Ancient bootloader, some functionality "
-		     "may be limited!\n");
+		puts("WARNING: Ancient bootloader, some functionality may be limited!\n");
 	}
 }
 
@@ -149,12 +147,11 @@ void main(void)
 
 	/* Make sure we have all the proper CPU support */
 	if (validate_cpu()) {
-		puts("Unable to boot - please use a kernel appropriate "
-		     "for your CPU.\n");
+		puts("Unable to boot - please use a kernel appropriate for your CPU.\n");
 		die();
 	}
 
-	/* Tell the BIOS what CPU mode we intend to run in. */
+	/* Tell the BIOS what CPU mode we intend to run in */
 	set_bios_mode();
 
 	/* Detect memory layout */

