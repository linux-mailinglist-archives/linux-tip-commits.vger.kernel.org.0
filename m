Return-Path: <linux-tip-commits+bounces-7986-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED974D1E2F8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10D9C30B716F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B73394469;
	Wed, 14 Jan 2026 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vKoe2nYH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+gvlzGyG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E83238F95D;
	Wed, 14 Jan 2026 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387214; cv=none; b=j5Mf0PQacw6UDX6OYeel1EDDCkAchsjeTL+S5V5igE79d5l0KEVbRNcW9Z2EyYp+7jBl9OX4rzBD4a+uUK4EmIcsXpeoIgFo8w4+9N+pe5ST5m0Vwo/27kkxh/9BwY6NE5PtnXKbhK3pihDvX10QnHunk/6iLp8mI5EPSq4CDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387214; c=relaxed/simple;
	bh=G1DO150FTFE9XvDZSzF1UVvYLKzamsH7ap3n8EjiHsI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ipH6/aFKg2B9Oiqyn4yfyvDu0TJZAhvXC3rQudzFhgU7k2/QqE6REo7ArP5ysF3yd6CHAUI3S+wvQQOk30M10PKkIDe4D6vlRAPG6qCCLgv0Qt5eyaEUd7RpvfalpglXgKsBKxRZ9j6qxvEBSGE6ISPeZp8gTEZxecMeMgzunxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vKoe2nYH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+gvlzGyG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnR/xoOPJ5TcDdIQZC7ik219i67CqM4U046cvIp7pao=;
	b=vKoe2nYHEvI4IjkBXYZ58zQlBn52I1mtD7ppRGj9Jdo3D1HbZWx+30t+RkkDmkqaXF4NjU
	aYymlfAJuuFhWnqZ/KSs3N6/TPvQN3AXjf6HrMukmqhZpDRHG6J22PBpsJ80Vmibmz902R
	PlY+wfBE4iXe9CNhed4H5FTNRcRcdZpPdIebNIwoyzacdyNkywrTO18AmEWnlDraFGmgc9
	hDUCJZ77QTQfSyE44Vs7PPlfKKSnjvAB/rG5BpXazEhsil93KMzoinmdobURMFWE6rel9P
	jXxqZ5NHjnNfRzJx3YgUs4qJyNs8Mn9Rg8CcH1HpY0tQ7NIISi0wRQvf3qDErg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnR/xoOPJ5TcDdIQZC7ik219i67CqM4U046cvIp7pao=;
	b=+gvlzGyGojx3k8O0iPphbwThvOwF5eVWtDpvMOpkBIK7/bWwOHpIaqlA0+4VrkduW5dU9r
	D8eQHk1sK4mi8UCw==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/xen: Drop xen_cpu_ops
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-17-jgross@suse.com>
References: <20260105110520.21356-17-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838720481.510.15742423398269790646.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     817f66e39e39b914aac25065a34f4462ab45ed26
Gitweb:        https://git.kernel.org/tip/817f66e39e39b914aac25065a34f4462ab4=
5ed26
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:15 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 19:53:20 +01:00

x86/xen: Drop xen_cpu_ops

Instead of having a pre-filled array xen_cpu_ops for Xen PV paravirt
functions, drop the array and assign each element individually.

This is in preparation of reducing the paravirt include hell by
splitting paravirt.h into multiple more fine grained header files,
which will in turn require to split up the pv_ops vector as well.
Dropping the pre-filled array makes life easier for objtool to
detect missing initializers in multiple pv_ops_ arrays.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Link: https://patch.msgid.link/20260105110520.21356-17-jgross@suse.com
---
 arch/x86/xen/enlighten_pv.c | 82 ++++++++++++++----------------------
 tools/objtool/check.c       |  1 +-
 2 files changed, 33 insertions(+), 50 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index b74ff8b..8a19a88 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1212,54 +1212,6 @@ static const struct pv_info xen_info __initconst =3D {
 	.name =3D "Xen",
 };
=20
-static const typeof(pv_ops) xen_cpu_ops __initconst =3D {
-	.cpu =3D {
-		.cpuid =3D xen_cpuid,
-
-		.set_debugreg =3D xen_set_debugreg,
-		.get_debugreg =3D xen_get_debugreg,
-
-		.read_cr0 =3D xen_read_cr0,
-		.write_cr0 =3D xen_write_cr0,
-
-		.write_cr4 =3D xen_write_cr4,
-
-		.read_msr =3D xen_read_msr,
-		.write_msr =3D xen_write_msr,
-
-		.read_msr_safe =3D xen_read_msr_safe,
-		.write_msr_safe =3D xen_write_msr_safe,
-
-		.read_pmc =3D xen_read_pmc,
-
-		.load_tr_desc =3D paravirt_nop,
-		.set_ldt =3D xen_set_ldt,
-		.load_gdt =3D xen_load_gdt,
-		.load_idt =3D xen_load_idt,
-		.load_tls =3D xen_load_tls,
-		.load_gs_index =3D xen_load_gs_index,
-
-		.alloc_ldt =3D xen_alloc_ldt,
-		.free_ldt =3D xen_free_ldt,
-
-		.store_tr =3D xen_store_tr,
-
-		.write_ldt_entry =3D xen_write_ldt_entry,
-		.write_gdt_entry =3D xen_write_gdt_entry,
-		.write_idt_entry =3D xen_write_idt_entry,
-		.load_sp0 =3D xen_load_sp0,
-
-#ifdef CONFIG_X86_IOPL_IOPERM
-		.invalidate_io_bitmap =3D xen_invalidate_io_bitmap,
-		.update_io_bitmap =3D xen_update_io_bitmap,
-#endif
-		.io_delay =3D xen_io_delay,
-
-		.start_context_switch =3D xen_start_context_switch,
-		.end_context_switch =3D xen_end_context_switch,
-	},
-};
-
 static void xen_restart(char *msg)
 {
 	xen_reboot(SHUTDOWN_reboot);
@@ -1411,7 +1363,39 @@ asmlinkage __visible void __init xen_start_kernel(stru=
ct start_info *si)
=20
 	/* Install Xen paravirt ops */
 	pv_info =3D xen_info;
-	pv_ops.cpu =3D xen_cpu_ops.cpu;
+
+	pv_ops.cpu.cpuid =3D xen_cpuid;
+	pv_ops.cpu.set_debugreg =3D xen_set_debugreg;
+	pv_ops.cpu.get_debugreg =3D xen_get_debugreg;
+	pv_ops.cpu.read_cr0 =3D xen_read_cr0;
+	pv_ops.cpu.write_cr0 =3D xen_write_cr0;
+	pv_ops.cpu.write_cr4 =3D xen_write_cr4;
+	pv_ops.cpu.read_msr =3D xen_read_msr;
+	pv_ops.cpu.write_msr =3D xen_write_msr;
+	pv_ops.cpu.read_msr_safe =3D xen_read_msr_safe;
+	pv_ops.cpu.write_msr_safe =3D xen_write_msr_safe;
+	pv_ops.cpu.read_pmc =3D xen_read_pmc;
+	pv_ops.cpu.load_tr_desc =3D paravirt_nop;
+	pv_ops.cpu.set_ldt =3D xen_set_ldt;
+	pv_ops.cpu.load_gdt =3D xen_load_gdt;
+	pv_ops.cpu.load_idt =3D xen_load_idt;
+	pv_ops.cpu.load_tls =3D xen_load_tls;
+	pv_ops.cpu.load_gs_index =3D xen_load_gs_index;
+	pv_ops.cpu.alloc_ldt =3D xen_alloc_ldt;
+	pv_ops.cpu.free_ldt =3D xen_free_ldt;
+	pv_ops.cpu.store_tr =3D xen_store_tr;
+	pv_ops.cpu.write_ldt_entry =3D xen_write_ldt_entry;
+	pv_ops.cpu.write_gdt_entry =3D xen_write_gdt_entry;
+	pv_ops.cpu.write_idt_entry =3D xen_write_idt_entry;
+	pv_ops.cpu.load_sp0 =3D xen_load_sp0;
+#ifdef CONFIG_X86_IOPL_IOPERM
+	pv_ops.cpu.invalidate_io_bitmap =3D xen_invalidate_io_bitmap;
+	pv_ops.cpu.update_io_bitmap =3D xen_update_io_bitmap;
+#endif
+	pv_ops.cpu.io_delay =3D xen_io_delay;
+	pv_ops.cpu.start_context_switch =3D xen_start_context_switch;
+	pv_ops.cpu.end_context_switch =3D xen_end_context_switch;
+
 	xen_init_irq_ops();
=20
 	/*
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0c32a92..8ab88f2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -570,7 +570,6 @@ static int init_pv_ops(struct objtool_file *file)
 {
 	static const char *pv_ops_tables[] =3D {
 		"pv_ops",
-		"xen_cpu_ops",
 		"xen_mmu_ops",
 		NULL,
 	};

