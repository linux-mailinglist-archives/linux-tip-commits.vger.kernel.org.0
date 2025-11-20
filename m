Return-Path: <linux-tip-commits+bounces-7436-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7998FC7632B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 21:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 099794E2165
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 20:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50F330B0E;
	Thu, 20 Nov 2025 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eoPpPwUn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sLtuLF9V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACDB307499;
	Thu, 20 Nov 2025 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670391; cv=none; b=ZIB17CklljtFUUFH3I4MfB2hWw41vhzuSmvc69MpA0FuZQUlIXnQwcPw2aU49qAMyNkQngHSHtPj+VpJl63USwlLWln14oHyuT/vYoc/f/fITYXtFqbgConpbiSEr4NUgGH1hW7GRo2QhU8spZqbHoi66rTGGFQEFnXfRSteI0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670391; c=relaxed/simple;
	bh=36ginY32UKJKyMZ132QuEDc9MazKLw/C54x/BwVhuA4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ahlecjN0r9+RSlcBL2ruG6WKORYEFzy06LIXvXJ6oOXg8B2mEU8cpNcFnacw6+1fPo+2H+Ocja/f16HDVUjCxkHMWb1QhcUDoXp5DO/M6TC6aRG99SLza2HDFSuD87uRko7z65JlHrCEUpqAWMHSkKncOOMfGI+rFGXL/NFuLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eoPpPwUn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sLtuLF9V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 20:26:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763670387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EA3laptp9DUcAceJVTXA+/IQrZgPZ418BK+tPncYbQs=;
	b=eoPpPwUnfk/6kDQipRpMjn9jNS71kzfj2iCFzxPy3RPUvbr7RkjSprd0XuduQjl+5xP65P
	Q4SZHxoUjHGhZRlr4d1nOl9x5FuDghRrVAJ+18TeSnoIeM5Tv8kEfRbdXmZ5chIUixOQsb
	wVKZrt9jDhXmINOAaeM8qCSpIFtNqFUr6oort56xv6134cF+1MBZp+83PXs9t/41hKPN9j
	PgINyKnx/9O1LbyPIXdR5BAZlZlxBuJTP+ow39b5xEw0ylLu24/GdF357QoqW+iUBwXnSo
	Ii2kqyYU5wUVGyo/REqGmLKqplap9ju9tAIYJz0ofCjhAGD9nQm8oKEwePZ7gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763670387;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EA3laptp9DUcAceJVTXA+/IQrZgPZ418BK+tPncYbQs=;
	b=sLtuLF9VXKdxp1mg8kj6R6oCVxMSiesIzbCimgEhKWw2LdAnPq6HA56KEtYQYVbkYEqy/0
	4Wkzkr9FihJ5KrBA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/boot: Drop unused sev_enable() fallback
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250909080631.2867579-6-ardb+git@google.com>
References: <20250909080631.2867579-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176367038604.498.13157799126201872220.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     a3e69071289288e2721ba15254e7c5274eddd05a
Gitweb:        https://git.kernel.org/tip/a3e69071289288e2721ba15254e7c5274ed=
dd05a
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 09 Sep 2025 10:06:33 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 20 Nov 2025 21:12:48 +01:00

x86/boot: Drop unused sev_enable() fallback

The misc.h header is not included by the EFI stub, which is the only
C caller of sev_enable(). This means the fallback for cases where
CONFIG_AMD_MEM_ENCRYPT is not set is never used, so it can be dropped.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://patch.msgid.link/20250909080631.2867579-6-ardb+git@google.com
---
 arch/x86/boot/compressed/misc.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index db10486..fd855e3 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -152,17 +152,6 @@ bool insn_has_rep_prefix(struct insn *insn);
 void sev_insn_decode_init(void);
 bool early_setup_ghcb(void);
 #else
-static inline void sev_enable(struct boot_params *bp)
-{
-	/*
-	 * bp->cc_blob_address should only be set by boot/compressed kernel.
-	 * Initialize it to 0 unconditionally (thus here in this stub too) to
-	 * ensure that uninitialized values from buggy bootloaders aren't
-	 * propagated.
-	 */
-	if (bp)
-		bp->cc_blob_address =3D 0;
-}
 static inline void snp_check_features(void) { }
 static inline void sev_es_shutdown_ghcb(void) { }
 static inline bool sev_es_check_ghcb_fault(unsigned long address)

