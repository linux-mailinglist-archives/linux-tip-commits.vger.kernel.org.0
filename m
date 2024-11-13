Return-Path: <linux-tip-commits+bounces-2846-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E9F9C70AB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 14:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC078B2278A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80AD1DF992;
	Wed, 13 Nov 2024 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zqv6mmGq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uop5wDUD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6391DF726;
	Wed, 13 Nov 2024 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504471; cv=none; b=FbOje6nuBzxqLh1D//OSrpHFaazHqaBBNAcHaZqfXVo5alqBU6QEkITENdM4VoOQPEhyODY8crunZ36riniALWk5yvA/Zx1xFfhaeQvMhaH4rGwVmSHkZ8gJBZt6SZpFSrluWTG2zRp5Myp1K6aDxIuEyxVNOxN/Prennlwjjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504471; c=relaxed/simple;
	bh=J9yxasEbYowNRW4nZJbnWfVL09gPm+1ief1daBCuv/k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hBk+VcIv3mye5krtwlhdhOJTdm1oW1WwXEC+BObroSqoESoEkf4r2wphX/IFojFIbuigVxO6hhpAHl4SMtPXqDbYlSw7gyPzfomROs+ruQKWLsSzpGgomPGlMCEj0PISCgf1s6vFLbXanXuk3l7smxRFBp6IwFWIamf6lvgdtl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zqv6mmGq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uop5wDUD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 13:27:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731504467;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnB/L9/F1cKPIDEoxPYFJ8A8etC5YOv19oQZSUDH6do=;
	b=Zqv6mmGqAgZvCLfnmW5jpsOhCiv5jPhno9J8PkVJfNT44zHmI+GhrxA+x1QXCnM3pzIeeF
	v3HtOzvAgfHFbwYYT3g4L6ds/ioBEPAdkqTcyMl4uOB4iI87Cy/EEPTSCz7KjDDLdc/ULr
	pYBMHNIIro35GToglutzsb/hHKh/1Iu5jyqEetmFitKDpd4w8od4/HNzWf5yFhssEy+BXv
	mlD8iI23mIA1l+4Hb03uoE+17RjvVzJnxOCjW3noHXTK49RyIOg3HFc9UFcQNZVzro86Ws
	ySurvEEB2g0Ju1x9htZB4MGEr5/mXMw5vES5lcK25W9eHI8qz+xU2omJtZ+RAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731504467;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnB/L9/F1cKPIDEoxPYFJ8A8etC5YOv19oQZSUDH6do=;
	b=Uop5wDUDI5s3I5uHJWGqyaDZTuLU/EUwf9TAqbmgB4moxS5w0aQVLGQ9Hxpxd0H71Xqj4g
	6QJFSUUBhcaNIDDg==
From: "tip-bot2 for Baoquan He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Fix a kdump kernel failure on SME system
 when CONFIG_IMA_KEXEC=y
Cc: Baoquan He <bhe@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240911081615.262202-3-bhe@redhat.com>
References: <20240911081615.262202-3-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173150446683.32228.2872819048173531578.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8d9ffb2fe65a6c4ef114e8d4f947958a12751bbe
Gitweb:        https://git.kernel.org/tip/8d9ffb2fe65a6c4ef114e8d4f947958a127=
51bbe
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Wed, 11 Sep 2024 16:16:15 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 13 Nov 2024 14:11:33 +01:00

x86/mm: Fix a kdump kernel failure on SME system when CONFIG_IMA_KEXEC=3Dy

The kdump kernel is broken on SME systems with CONFIG_IMA_KEXEC=3Dy enabled.
Debugging traced the issue back to

  b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec").

Testing was previously not conducted on SME systems with CONFIG_IMA_KEXEC
enabled, which led to the oversight, with the following incarnation:

...
  ima: No TPM chip found, activating TPM-bypass!
  Loading compiled-in module X.509 certificates
  Loaded X.509 cert 'Build time autogenerated kernel key: 18ae0bc7e79b6470012=
2bb1d6a904b070fef2656'
  ima: Allocated hash algorithm: sha256
  Oops: general protection fault, probably for non-canonical address 0xcfacfd=
fe6660003e: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc2+ #14
  Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.20.0 05/03/2023
  RIP: 0010:ima_restore_measurement_list
  Call Trace:
   <TASK>
   ? show_trace_log_lvl
   ? show_trace_log_lvl
   ? ima_load_kexec_buffer
   ? __die_body.cold
   ? die_addr
   ? exc_general_protection
   ? asm_exc_general_protection
   ? ima_restore_measurement_list
   ? vprintk_emit
   ? ima_load_kexec_buffer
   ima_load_kexec_buffer
   ima_init
   ? __pfx_init_ima
   init_ima
   ? __pfx_init_ima
   do_one_initcall
   do_initcalls
   ? __pfx_kernel_init
   kernel_init_freeable
   kernel_init
   ret_from_fork
   ? __pfx_kernel_init
   ret_from_fork_asm
   </TASK>
  Modules linked in:
  ---[ end trace 0000000000000000 ]---
  ...
  Kernel panic - not syncing: Fatal exception
  Kernel Offset: disabled
  Rebooting in 10 seconds..

Adding debug printks showed that the stored addr and size of ima_kexec buffer
are not decrypted correctly like:

  ima: ima_load_kexec_buffer, buffer:0xcfacfdfe6660003e, size:0xe48066052d5df=
359

Three types of setup_data info

  =E2=80=94 SETUP_EFI,
  - SETUP_IMA, and
  - SETUP_RNG_SEED

are passed to the kexec/kdump kernel. Only the ima_kexec buffer
experienced incorrect decryption. Debugging identified a bug in
early_memremap_is_setup_data(), where an incorrect range calculation
occurred due to the len variable in struct setup_data ended up only
representing the length of the data field, excluding the struct's size,
and thus leading to miscalculation.

Address a similar issue in memremap_is_setup_data() while at it.

  [ bp: Heavily massage. ]

Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20240911081615.262202-3-bhe@redhat.com
---
 arch/x86/mm/ioremap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 70b02fc..8d29163 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -656,7 +656,8 @@ static bool memremap_is_setup_data(resource_size_t phys_a=
ddr,
 		paddr_next =3D data->next;
 		len =3D data->len;
=20
-		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
+		if ((phys_addr > paddr) &&
+		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
 			memunmap(data);
 			return true;
 		}
@@ -718,7 +719,8 @@ static bool __init early_memremap_is_setup_data(resource_=
size_t phys_addr,
 		paddr_next =3D data->next;
 		len =3D data->len;
=20
-		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
+		if ((phys_addr > paddr) &&
+		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
 			early_memunmap(data, sizeof(*data));
 			return true;
 		}

