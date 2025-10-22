Return-Path: <linux-tip-commits+bounces-6980-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 905DABFBC19
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Oct 2025 14:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04FF6353F64
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Oct 2025 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189F3340A6C;
	Wed, 22 Oct 2025 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mOoUhNYh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6RKYgZUj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C6532AAAC;
	Wed, 22 Oct 2025 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134509; cv=none; b=t5mY1bnh4dthBvfoCtxP6zVNm49MHYnoq2NQszWyE6mJU1j4r3lYpJRIBhefW/ZLvNrvIbjqsHKx6yVlmRnA+r49UVBaZL27Le0ymbn+mOb+xo3aSRiChoG4sY7FVptTsAVd8Xt3oxjV4z5BAEuIkwDuPnCoo4ajaOCyJd5Wol8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134509; c=relaxed/simple;
	bh=ioBibAcvdFoxYXHmUAvx07BG3CWdNQQf12x9MxqDkkY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qa+Oe6ImkI+kuHWFvpfWO0MswN6m5wtHFEu1lFxrQDthKIsKW33uSj4bNoYn8UCA/R6JryblKWd6KXIkfpzNBlt/qHYXG8RGsV4+M04oGCpIDOnQ/zrk9zu+6q3BBm2GzJhW1piYS2XmtEPjpz2TTEcmSIYB+FSwJpjurlTWrpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mOoUhNYh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6RKYgZUj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 22 Oct 2025 12:01:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761134498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbTZK8K7zjHJ5PVUnvje4mxWgwKeS4mV4YNw34fSt+M=;
	b=mOoUhNYhib/PRqvLMT7QsAd+CRWwhCpQIA38mp673F59TSU6yIsCf2oRZ/U4ttTpo/ahXE
	HsC3M/bZ/ZozrrzeuF1ipocS8kG6iAcugReqcTGfZ3nwTWCENU521rEIMTlZEp1qBOcK/3
	xphju9vMilvFNAbx3MjLLfj0qHHiukM5ASMU/7CyjgzAuygbv2r6wRP3OJ7bSAJ9lZ1Sh2
	bEjxoR4Nn6lIO9MUas/qwj1bLN6cYZ6/EkAafOKGExf2CSGweXPIXVICfqtycjQrf2hyVW
	j3qdL4Rax/Wg7db1mnWajos7PuZ9+3IUeEQswg3KvaDjBv/kqeCfHDc4551h9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761134498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AbTZK8K7zjHJ5PVUnvje4mxWgwKeS4mV4YNw34fSt+M=;
	b=6RKYgZUjFd6lldsMvh8XqZfbjAwJ17T4ZNZhDd984NjycY5pHwak2K+/UXWZmjl1StCY4E
	NSiwXIIb9s0PNBBg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/klp: Add the debian-based package name of
 xxhash to the hint
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251017194732.7713-1-bp@kernel.org>
References: <20251017194732.7713-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176113449564.2601451.10781814122557793113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     da247eff96dd32380dfb0cb089be8671ac4bdcd0
Gitweb:        https://git.kernel.org/tip/da247eff96dd32380dfb0cb089be8671ac4=
bdcd0
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 17 Oct 2025 21:47:32 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 22 Oct 2025 13:51:11 +02:00

objtool/klp: Add the debian-based package name of xxhash to the hint

Add the debian package name for the devel version of the xxHash package
"libxxhash-dev".

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251017194732.7713-1-bp@kernel.org
---
 tools/objtool/builtin-check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 7b6fd60..1e1ea83 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -164,7 +164,7 @@ static bool opts_valid(void)
=20
 #ifndef BUILD_KLP
 	if (opts.checksum) {
-		ERROR("--checksum not supported; install xxhash-devel and recompile");
+		ERROR("--checksum not supported; install xxhash-devel/libxxhash-dev and re=
compile");
 		return false;
 	}
 #endif

