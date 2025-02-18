Return-Path: <linux-tip-commits+bounces-3512-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1284A39BE0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537701752ED
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A112475C2;
	Tue, 18 Feb 2025 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hbg2gGb7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fEsfFxTK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013FE246352;
	Tue, 18 Feb 2025 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880715; cv=none; b=WsGElOtLZ7fNZF9N5ZWpfB02653q4VFQ30qaeK+gc0Hm8nBK6tDJwf+SbfyjZE6r06zmHlsT34Sr85PB37JusfwjkUoX0fNNyu9JOYhAc8DuMwHu5KSapVeEq3xgsB3YhIgMxI0DVVKL1R35CEGtJuf4guKpu2pPvm53xmHTuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880715; c=relaxed/simple;
	bh=tJjUAduDWi0si2VmrDCgDD/eLKho3zhd5xv6GkxOjKs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L7u11ix7R+XhunlaUsiCVgdd5KW+bEfFz+EsbUx24JPo6WrcHjSSdi6jjluUD2KaHgY9duJxGEZeQvLojYL6NggArAGrg1qXEdulvLLLz1PZ4OVV+PKEjWBFedJusGMS6uLTQeAum22GGbQWrp7aR3OCI/8G66ZyeWwY+Uy/fUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hbg2gGb7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fEsfFxTK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPvC7hQ+Awk42Ia7gTkhHZTy7358l0pGiCUamQ/r1QQ=;
	b=hbg2gGb7/1UZ5yeQNpKaO6u6w7ui9LbxCjzNAnPQIuuvu9IxbG0g20D4HZoFihFjQwpY03
	lR5eZ72Xn9IhYeyO3Ciki/6NzT5f5PYbDfCY1mZt28h9eMgQWMF1i9ZPPM+V99JxSbb9a5
	qZ1UL5hlVKxmblWd8nSZsdPbPdDhon44COi5Ux8boCtj4gS3bSfLB0bS814CfkzqgZgG4q
	uY2Lm5NwRXL6tWf/ndNeotvsOdkjk9D9CukseZFE/iug8bPjqGdi7b4TVcFPFHOFmTdwwY
	eqfYm3kO8wBfqUxc7u+o/AuAOpOLExtZtsEYi59C6/BU/1ZgwkPctC5zUShFfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880712;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPvC7hQ+Awk42Ia7gTkhHZTy7358l0pGiCUamQ/r1QQ=;
	b=fEsfFxTKkRiyXBejPHl+yjFd8TrMBm7YhtUHMXNvVbuENh8F6lq5XPGJD9SweqxFswX1E7
	u0uYigEH9BsYCOBQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-6-brgerst@gmail.com>
References: <20250123190747.745588-6-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988071204.10177.9606785227341868570.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     cb7927fda002ca49ae62e2782c1692acc7b80c67
Gitweb:        https://git.kernel.org/tip/cb7927fda002ca49ae62e2782c1692acc7b80c67
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 23 Jan 2025 14:07:37 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 10:15:02 +01:00

x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations

Clang may produce R_X86_64_REX_GOTPCRELX relocations when redefining the
stack protector location.  Treat them as another type of PC-relative
relocation.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-6-brgerst@gmail.com
---
 arch/x86/tools/relocs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e937be9..92a1e50 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -32,6 +32,11 @@ static struct relocs		relocs32;
 static struct relocs		relocs32neg;
 static struct relocs		relocs64;
 # define FMT PRIu64
+
+#ifndef R_X86_64_REX_GOTPCRELX
+# define R_X86_64_REX_GOTPCRELX 42
+#endif
+
 #else
 # define FMT PRIu32
 #endif
@@ -227,6 +232,7 @@ static const char *rel_type(unsigned type)
 		REL_TYPE(R_X86_64_PC16),
 		REL_TYPE(R_X86_64_8),
 		REL_TYPE(R_X86_64_PC8),
+		REL_TYPE(R_X86_64_REX_GOTPCRELX),
 #else
 		REL_TYPE(R_386_NONE),
 		REL_TYPE(R_386_32),
@@ -861,6 +867,7 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 
 	case R_X86_64_PC32:
 	case R_X86_64_PLT32:
+	case R_X86_64_REX_GOTPCRELX:
 		/*
 		 * PC relative relocations don't need to be adjusted unless
 		 * referencing a percpu symbol.

