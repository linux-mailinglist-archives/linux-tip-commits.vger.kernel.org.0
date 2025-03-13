Return-Path: <linux-tip-commits+bounces-4201-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B1DA5FEE0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 19:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E475C188CA28
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDE11E9B26;
	Thu, 13 Mar 2025 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lj8nzhz/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VfHjNKEK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE61C84CB;
	Thu, 13 Mar 2025 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889463; cv=none; b=isbbZ//ZGeEokHvI5KlGQ1RZ2vBTZcEEFvYShweUgPnZmK+2mHGOXz51G8G4A/e2V88L+fPdQyLh6OcUtJN02BRWBOteIJ9pfRsSezZQqPDeOeEUVbQTgVvJfzad6gY1fLElzkDlJSZVf7J5n+THk/QRvMy9UtSHb+q5y6OMD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889463; c=relaxed/simple;
	bh=wBrs6IsEkOi3FRBo2YtYplP3f65GpmL3dkOKG8LqvM8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gn+7L05vGnxUqrh5Umh7sCOuZZ5OVZKZ2TecK6bGBwsXMkeBPPz6upCDs2sqgTmLl368TuX1HswUVOKeOS3Pnz3qcA1N0iZNmKrpUvGYSY2N+WzyAoFUq87EPvlpSPoEdRBwoLXIxmmMcxkGpOgU6XyJoX7n0o3OFRU2lDop/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lj8nzhz/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VfHjNKEK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 18:10:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741889458;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLQo1hFi2Zeua/VEe8ZtQkIGsCxgyiW7vBpaLvp/aW0=;
	b=lj8nzhz/UMXg2mprS06OO6ryDKfndclizmhSfafEH8yUr9e21QCq7Z5OgrtBvoH5Wue+nq
	oc8D2ugg8QGvZp4YONbyGLPlleUwiLOeNXnQCK4oicMdEke2tt7ZDGJXk1JibrLzwtbgJM
	DzwCqIhNCDADBD1dreH7c29G9FcKkQs2wgN/kjVMvPNUBmX/aIyJ+9a0XIVomlVRO9vgh+
	fVXplNrAYBFgf7uceN1PBmwvgv6csub41Fm8ydtHL/qZKauKXuhwggbXu4ijXNOxg3azMt
	Z4/q+Hhmv804rOU3/JqxfXg8nVfwkUwZ+Hn88sEOEamOl6EA2mwhvsU27C0KHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741889458;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uLQo1hFi2Zeua/VEe8ZtQkIGsCxgyiW7vBpaLvp/aW0=;
	b=VfHjNKEKBp6vePUQhMvrChSwjRzkP0rmnpSkEedbxrIVsONSmMYFOv57QafbBo6UFoKDza
	3Yx+oa+jJAJdRkCg==
From: "tip-bot2 for Ajay Kaher" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/vmware: Parse MP tables for SEV-SNP enabled
 guests under VMware hypervisors
Cc: Ye Li <ye.li@broadcom.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Ingo Molnar <mingo@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313173111.10918-1-ajay.kaher@broadcom.com>
References: <20250313173111.10918-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174188945627.14745.9945316413409402163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a2ab25529bbcea51b5e01dded79f45aeb94f644a
Gitweb:        https://git.kernel.org/tip/a2ab25529bbcea51b5e01dded79f45aeb94f644a
Author:        Ajay Kaher <ajay.kaher@broadcom.com>
AuthorDate:    Thu, 13 Mar 2025 17:31:11 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 Mar 2025 19:01:09 +01:00

x86/vmware: Parse MP tables for SEV-SNP enabled guests under VMware hypervisors

Under VMware hypervisors, SEV-SNP enabled VMs are fundamentally able to boot
without UEFI, but this regressed a year ago due to:

  0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for SEV-SNP guests")

In this case, mpparse_find_mptable() has to be called to parse MP
tables which contains the necessary boot information.

[ mingo: Updated the changelog. ]

Fixes: 0f4a1e80989a ("x86/sev: Skip ROM range scans and validation for SEV-SNP guests")
Co-developed-by: Ye Li <ye.li@broadcom.com>
Signed-off-by: Ye Li <ye.li@broadcom.com>
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Ye Li <ye.li@broadcom.com>
Reviewed-by: Kevin Loughlin <kevinloughlin@google.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250313173111.10918-1-ajay.kaher@broadcom.com
---
 arch/x86/kernel/cpu/vmware.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 00189cd..cb3f900 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -26,6 +26,7 @@
 #include <linux/export.h>
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
+#include <linux/efi.h>
 #include <linux/reboot.h>
 #include <linux/static_call.h>
 #include <asm/div64.h>
@@ -429,6 +430,9 @@ static void __init vmware_platform_setup(void)
 		pr_warn("Failed to get TSC freq from the hypervisor\n");
 	}
 
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !efi_enabled(EFI_BOOT))
+		x86_init.mpparse.find_mptable = mpparse_find_mptable;
+
 	vmware_paravirt_ops_setup();
 
 #ifdef CONFIG_X86_IO_APIC

