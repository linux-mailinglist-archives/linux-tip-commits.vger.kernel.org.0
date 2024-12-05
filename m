Return-Path: <linux-tip-commits+bounces-2977-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCB69E5571
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 13:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5A816AAF1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Dec 2024 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A221A218847;
	Thu,  5 Dec 2024 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xfktQm+L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x60RF6/D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3909217F3F;
	Thu,  5 Dec 2024 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401694; cv=none; b=qrS8Q2Aj908BwPTHfwLbjLCYJLdXGCbsp0SHKF0rlYzJMcOCNzZpN9AkqILUfxTwjP2kkFijMbm63GCfLe8+1sCnG0R6TsUMNcKaWMhhko856IaZQZMi/GyCb1ZdV64G0z7tCUFbE8nFG1sLgBgr3BF1gfV/PF8zIy7lrm9VfCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401694; c=relaxed/simple;
	bh=fZr6gMYrf9qWYDblYKf9JZMLakZTmpfHUIO/s/mjvYs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bXgg67irOo6epzCTnKfkMREhOCAgKrmeuoqEk78cUrOcLYFDq5QKDcCgmBdgzawzzyvPXnftctu4KbM5ux40XViPdoBAeSaXvF3Guap1sCPgbpUX8kz/asQfJXZ2/wdxrW9Qvdn4fO8ppzWFmDnA21DwOKRMYH0mNdxJAi27dEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xfktQm+L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x60RF6/D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Dec 2024 12:28:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733401691;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5InxtdpcNNQB4n8NfJXHFxOZ0s5D0NRYr+Pm5hOqhI=;
	b=xfktQm+LTqghKm/qlKren41AKkm2byOjaAF7PpLoiHIQxCYHdT5CkAdBrP1tzkPMgTlsrp
	1pYrE8MG9cGmw7vUmopuH6emLCJHUSiGadhyeANk8DWhnOKHwAXJWkdTw6nEkiT1tGRpYY
	luxRCubk2x8x3k5xDT7sy084XXYX0RdT83t23bzrxU4jasNZi62BcX+fZLwTdSyP7C1JRq
	lxgRHUt3Qk/jc7vKTdYnPa9WBXcjKTEeuuBR5OVzPNc3p8KKHBESA/EIzU7gEhtareLvgc
	wcH9JXlBioBmNnXm8MKI3FnkrTvB/XPPWsPXE1f0LJDKzt4oV11xP/AuM7O8uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733401691;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5InxtdpcNNQB4n8NfJXHFxOZ0s5D0NRYr+Pm5hOqhI=;
	b=x60RF6/Du9iN0ZzOxL/jUTy1kIM12TTuB4G3XDgs1i3b7hc2d7BuSasrzy3Fdw8p2cFEYJ
	j1Uh/zLVOJc1PhBg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/kernel: Move ENTRY_TEXT to the start of the image
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241205112804.3416920-14-ardb+git@google.com>
References: <20241205112804.3416920-14-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173340169061.412.4894013341636657713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     35350eb689e68897d996b762832782e2e791eb74
Gitweb:        https://git.kernel.org/tip/35350eb689e68897d996b762832782e2e791eb74
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 05 Dec 2024 12:28:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Dec 2024 13:18:55 +01:00

x86/kernel: Move ENTRY_TEXT to the start of the image

Since commit:

  7734a0f31e99 ("x86/boot: Robustify calling startup_{32,64}() from the decompressor code")

it is no longer necessary for .head.text to appear at the start of the
image. Since ENTRY_TEXT needs to appear PMD-aligned, it is easier to
just place it at the start of the image, rather than line it up with the
end of the .text section. The amount of padding required should be the
same, but this arrangement also permits .head.text to be split off and
emitted separately, which is needed by a subsequent change.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20241205112804.3416920-14-ardb+git@google.com
---
 arch/x86/kernel/vmlinux.lds.S | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index fab3ac9..1ce7889 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -121,19 +121,6 @@ SECTIONS
 	.text :  AT(ADDR(.text) - LOAD_OFFSET) {
 		_text = .;
 		_stext = .;
-		/* bootstrapping code */
-		HEAD_TEXT
-		TEXT_TEXT
-		SCHED_TEXT
-		LOCK_TEXT
-		KPROBES_TEXT
-		SOFTIRQENTRY_TEXT
-#ifdef CONFIG_MITIGATION_RETPOLINE
-		*(.text..__x86.indirect_thunk)
-		*(.text..__x86.return_thunk)
-#endif
-		STATIC_CALL_TEXT
-
 		ALIGN_ENTRY_TEXT_BEGIN
 		*(.text..__x86.rethunk_untrain)
 		ENTRY_TEXT
@@ -147,6 +134,19 @@ SECTIONS
 		*(.text..__x86.rethunk_safe)
 #endif
 		ALIGN_ENTRY_TEXT_END
+
+		/* bootstrapping code */
+		HEAD_TEXT
+		TEXT_TEXT
+		SCHED_TEXT
+		LOCK_TEXT
+		KPROBES_TEXT
+		SOFTIRQENTRY_TEXT
+#ifdef CONFIG_MITIGATION_RETPOLINE
+		*(.text..__x86.indirect_thunk)
+		*(.text..__x86.return_thunk)
+#endif
+		STATIC_CALL_TEXT
 		*(.gnu.warning)
 
 	} :text = 0xcccccccc

