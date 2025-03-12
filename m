Return-Path: <linux-tip-commits+bounces-4136-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0129EA5DC59
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 13:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395F5165A10
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 12:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A9A23F397;
	Wed, 12 Mar 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="12J00f5K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bv4eWJKs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8341DB356;
	Wed, 12 Mar 2025 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781378; cv=none; b=k9EYqBzj+qK2ZGgMtz2V2zLRKXccQwN8f8eENM6gOrU7G9lLV0NNmZmjkKaEngvwTgpU/RaYAmVpYDz0n2MqxBlzox1eGvwhvEcY4FhSL0YwAYoioZ+WOGvCC+CT4CJQn5yGzBZTh6Ckxy/8/OWU8ITn+RJDXLHrfZeZGY00C+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781378; c=relaxed/simple;
	bh=5mufl2D2VnjyFkVTpVLnTt4CyPP0aAxUvRAneUW3Cj4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VG5SK8JPIO00GyhwMP256yaf1fGlUVrQH1Vi7YF/kLBndeNJU0BSHkQHp0RJ3qUM+zJM/zdOXZFm1ofqpVb+QORlJ51i6JceHd12Ig+O6MiJY8aAbV5aViee5rjyj7ZPLPfVFl7fFG37iNbFh9AdjfpzFjIcYEyFR6Xcxd0KKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=12J00f5K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bv4eWJKs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 12:09:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741781375;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlGTpQqEeUE8eWV/pkzZFjU7vp6Bgt8GRLso4ga/W/w=;
	b=12J00f5KQFkdYMbpUbh0mcvR8+nHuASzFB/0DLPpLHSxnTbQ2R1LFxgQEfOR+1k8wt20Sw
	DYNuVzEgc6qIipMqdKmakJ/vyqlvCjaq6fR+MYxRggWyRfVpDwx3a0qiW+0UY0vHTwWhpF
	KhywB8cdlGuDpjv9hjY83f6RdcX4XNBWFJ9eaAqKYQEpWdDMZFscZ3M+wlwcPeH4knquId
	WJp8/DqsX3Yi3LR7q+2fzJADttJHdBqgRn9S5N8J0qPethwIZ14zRDli9nfGiYGMibv3Mv
	qi/nxkpn/PTuR1EpHp957ajg/rXskcB5lcOB4qejMl6qcrnxFOk0/fhYqdS6kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741781375;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlGTpQqEeUE8eWV/pkzZFjU7vp6Bgt8GRLso4ga/W/w=;
	b=Bv4eWJKsQ2ftbQINaRdoLfDchqQ1jlWcvKC8xkWnpQ/2VNfWASIwA6A3RFXyLOCqwD/zDJ
	4r06WJWHkLHR1ADQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/build] x86/boot: Add back some padding for the CRC-32 checksum
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Ian Campbell <ijc@hellion.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250312081204.521411-2-ardb+git@google.com>
References: <20250312081204.521411-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174178137443.14745.10057090473999621829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     e471a86a8c523eccdfd1c4745ed7ac7cbdcc1f3f
Gitweb:        https://git.kernel.org/tip/e471a86a8c523eccdfd1c4745ed7ac7cbdcc1f3f
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 12 Mar 2025 09:12:05 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 Mar 2025 13:04:52 +01:00

x86/boot: Add back some padding for the CRC-32 checksum

Even though no uses of the bzImage CRC-32 checksum are known, ensure
that the last 4 bytes of the image are unused zero bytes, so that the
checksum can be generated post-build if needed.

[ mingo: Added the 'obsolete' qualifier to the comment. ]

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ian Campbell <ijc@hellion.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250312081204.521411-2-ardb+git@google.com
---
 arch/x86/boot/compressed/vmlinux.lds.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 48d0b51..3b2bc61 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -48,7 +48,8 @@ SECTIONS
 		*(.data)
 		*(.data.*)
 
-		. = ALIGN(0x200);
+		/* Add 4 bytes of extra space for the obsolete CRC-32 checksum */
+		. = ALIGN(. + 4, 0x200);
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);

