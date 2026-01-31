Return-Path: <linux-tip-commits+bounces-8159-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJGdHygNfmlbVAIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8159-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 15:09:44 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB11C22D0
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 15:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81F57300231C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F5817A300;
	Sat, 31 Jan 2026 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+DO16LM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/9I4KAK3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC23542F4;
	Sat, 31 Jan 2026 14:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769868581; cv=none; b=n0kr75Z90HcoOUAv8CdynIhcLaT5hBpAfUNnAUymee0pw8+9oKqGGvyb1yD3kPOPKK5kiIZ7Xqxxs5m1CGIgej5n6HIokhlTDHVwt2IMYmE0Bl7LfiOOWp44TfJ9fSNU05Rsq5c0DV+H0nDgopvvb5pN5J2XhbRfxqARdbVEK0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769868581; c=relaxed/simple;
	bh=edlaLe+zC2ZBhpl1K7oiqgTirhzUOEb/ZtbvFOZAz0k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=adGdRV+D8Vn/LELzLrzCW9MvVuTFNldcY/BdKQ7orCSPuzeKQsQYRWc5Z54+tBG9rK5soqakgI7InYX9lfxUOJBI6WP+roFniB64j3gyOpFpSbGg2lvSjVk+r8zYsfW6r1aZxR957Es8rNbpi3EF57mEiqFyjVtcZbAtNt1v6Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T+DO16LM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/9I4KAK3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 31 Jan 2026 14:09:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769868571;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5wbb2jVtWfSwrjfVCxmWpNYCJVU6faBAKjHBdaVySk=;
	b=T+DO16LM2Jr7THuiUkcVDwvRBedyvOSkhOnvvpsZJnRLO8nG3QDXWzdJwNRplx8mtf7D8t
	hh1MfIw+1YChoq6JBgx8aQxiPb9r9HGaoYrYEPJrvvGQKEYEsY8DVLCzLbF0dzY83ZeZyy
	yF0Z2kVQ/eBYUloI9HtUbqVN8563+EuNnxr0FXB6vYTQnHg4fjf+cpi+m2hV9C+OwgQ2Ba
	VrNa7DvbMH5HGRO1t/sDdwYHY//2rulYdwJlRxrtbIHy4fHfw2wToJzY7UEuCpbzkvoegr
	Xl1e6uV47N+AXNtF6cuTXjJqxLfPPTx5k6tpHuyXT34o9ddG7jEx6zChe3Gbcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769868571;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5wbb2jVtWfSwrjfVCxmWpNYCJVU6faBAKjHBdaVySk=;
	b=/9I4KAK3r485vbKchX7I0MvaLDphfxt0gjGeLnfJp3OQV7VaNAU4XKFN6SEArF/H6GIJue
	VEiA4AHqemdmwmAA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Don't emit BSS_DECRYPTED section unless it is in use
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260108092526.28586-23-ardb@kernel.org>
References: <20260108092526.28586-23-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176986857025.2495410.14721949712327661606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8159-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 2CB11C22D0
X-Rspamd-Action: no action

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     8c89d3ad3095808ac130c535ad7ed3d1344d5986
Gitweb:        https://git.kernel.org/tip/8c89d3ad3095808ac130c535ad7ed3d1344=
d5986
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 08 Jan 2026 09:25:29=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 31 Jan 2026 14:42:53 +01:00

x86/sev: Don't emit BSS_DECRYPTED section unless it is in use

The BSS_DECRYPTED section that gets emitted into .bss will be empty if
CONFIG_AMD_MEM_ENCRYPT is not defined. However, due to the fact that it
is injected into .bss rather than emitted as a separate section, the
2 MiB alignment that it specifies is still taken into account
unconditionally, pushing .bss out to the next 2 MiB boundary, leaving
a gap that is never freed.

So only emit a non-empty BSS_DECRYPTED section if it is going to be
used.  In that case, it would still be nice to free the padding, but
that is left for later.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260108092526.28586-23-ardb@kernel.org
---
 arch/x86/kernel/vmlinux.lds.S | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index d7af4a6..3a24a3f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -67,7 +67,18 @@ const_cpu_current_top_of_stack =3D cpu_current_top_of_stac=
k;
=20
 #define ALIGN_ENTRY_TEXT_BEGIN	. =3D ALIGN(PMD_SIZE);
 #define ALIGN_ENTRY_TEXT_END	. =3D ALIGN(PMD_SIZE);
+#else
+
+#define X86_ALIGN_RODATA_BEGIN
+#define X86_ALIGN_RODATA_END					\
+		. =3D ALIGN(PAGE_SIZE);				\
+		__end_rodata_aligned =3D .;
=20
+#define ALIGN_ENTRY_TEXT_BEGIN
+#define ALIGN_ENTRY_TEXT_END
+#endif
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
 /*
  * This section contains data which will be mapped as decrypted. Memory
  * encryption operates on a page basis. Make this section PMD-aligned
@@ -88,17 +99,9 @@ const_cpu_current_top_of_stack =3D cpu_current_top_of_stac=
k;
 	__pi___end_bss_decrypted =3D .;				\
=20
 #else
-
-#define X86_ALIGN_RODATA_BEGIN
-#define X86_ALIGN_RODATA_END					\
-		. =3D ALIGN(PAGE_SIZE);				\
-		__end_rodata_aligned =3D .;
-
-#define ALIGN_ENTRY_TEXT_BEGIN
-#define ALIGN_ENTRY_TEXT_END
 #define BSS_DECRYPTED
-
 #endif
+
 #if defined(CONFIG_X86_64) && defined(CONFIG_KEXEC_CORE)
 #define KEXEC_RELOCATE_KERNEL					\
 	. =3D ALIGN(0x100);					\

