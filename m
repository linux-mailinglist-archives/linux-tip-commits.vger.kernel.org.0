Return-Path: <linux-tip-commits+bounces-5152-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514ACAA53E8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 20:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D383BFC0F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Apr 2025 18:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70842274FC9;
	Wed, 30 Apr 2025 18:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JVoFUfom";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sUPsLz26"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C551F1EEA46;
	Wed, 30 Apr 2025 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038469; cv=none; b=hgnosO6Ys2IXOAW0G762Td8J3uuuEO6/4oi7V4Tj2Cai5pSkwkaxlLF1rFxsId1HNiy+zZ2kSvU/Fk+KUaywIVVZwWx33zzW/bW1NrwlUIBQKDaZXmazwYGdVxhbUcJit0b0Y04nz0Nek7d/cHRLH6C7R/ciEq+/uTZs4Uw4uRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038469; c=relaxed/simple;
	bh=UUaUf856tNZAGw81fKnd/07euuyb4/etbgnyEOv5oJo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FRDl8zL0619xkLQiGkmBwJ7rmFTzpac9Y1CI21+RFOvceCMGR+mGMqAxZ0f4gYfTkJWR0aXWU5/aj7cAtGQcGWBXSfQI4YUWL8f9XGueQ8NhObJlchfYPvAZVG3dX8uBtRVd6e8g1LzIEgFKNaBONOgXx55QPhmXSBWjp1IEp4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JVoFUfom; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sUPsLz26; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 18:40:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746038465;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YiyyK53NvchIwLWDuCGfxT8rJhhzOXbrWtHsJAKspA=;
	b=JVoFUfomSFpLmnzQoNZR0IeTE9U/YChqFPq9mlScfOMpvZGr2ihkHLY1EE9GFjkSoLBsuX
	l1H2FqMHJlMyTsMauO4+amikYm5xndkyy7f9dKG3x+JO8iriT8byWC9ho5PqPetPBy7j61
	Mb05rI5k5PpfLB6HtEfVkPP2leISqqC9NT0tny1OJncvbCLwmslg5r8wNAsPvfZ5HRcNBg
	ljJOqbMsFa7d21FfLjcs8bZX2p1desOQvLnCBqbjhw3x7dlSvEGZDkWxtXfNJmDLxM8gxJ
	tNuiQvYvUwmDpCAuNGPgomXmzcornDjMcyZ0bokFLFrp+qTZZSUzZQvQ1H5VRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746038465;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1YiyyK53NvchIwLWDuCGfxT8rJhhzOXbrWtHsJAKspA=;
	b=sUPsLz26ZUMf7xw4mc2lSzwI7HLEoBIB8Z5S+SijJLPLUaZzCKKIWI3EgvKB6UuI5hvCPY
	KLAAuGNOGVScrxCQ==
From: "tip-bot2 for Ruben Wauters" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/CPU/AMD: Replace strcpy() with strscpy()
Cc: Ruben Wauters <rubenru09@aol.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250429230710.54014-1-rubenru09@aol.com>
References: <20250429230710.54014-1-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174603846015.22196.17079142660288754024.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     003f144ca04621e598fc1c5c4ce0a851cddfe104
Gitweb:        https://git.kernel.org/tip/003f144ca04621e598fc1c5c4ce0a851cddfe104
Author:        Ruben Wauters <rubenru09@aol.com>
AuthorDate:    Wed, 30 Apr 2025 00:03:59 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 30 Apr 2025 19:32:36 +02:00

x86/CPU/AMD: Replace strcpy() with strscpy()

strcpy() is deprecated due to issues with bounds checking and overflows.
Replace it with strscpy().

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250429230710.54014-1-rubenru09@aol.com
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2b36379..0feb717 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -643,7 +643,7 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 	}
 
 	if (!c->x86_model_id[0])
-		strcpy(c->x86_model_id, "Hammer");
+		strscpy(c->x86_model_id, "Hammer");
 
 #ifdef CONFIG_SMP
 	/*

