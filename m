Return-Path: <linux-tip-commits+bounces-5129-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF148A9F959
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Apr 2025 21:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14B23AE9E8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Apr 2025 19:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88F82951B5;
	Mon, 28 Apr 2025 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GWpOuszU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mJ9R/yS4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21822957CB;
	Mon, 28 Apr 2025 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745868126; cv=none; b=GKfuMSyefPHJ/5MYr2DnIkc+p1jZUg4n4BJPRpmwm2zZ5QlnTVIoTuZ+5EysK7smI5IHfUMPGF6DD2pgsjL+jMrIh5SpkfQmACulL3GseAPZCzMZnftDTqvW92hbZibrNxKMpl4fEdOl2km1lZs6i3m7nKAI5cNM1swCVny2UH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745868126; c=relaxed/simple;
	bh=HtfokJNJj34J3mCE9iyrn/maZxeUZcOgwla6przObF8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BP+uDhIm50WtTIESvMhJxd+guLB92CKECBSf50qUdfke7dpekP3fDskA81VzHLhKiR9Pia5qu6YRbFyA+2yhBa4j5XClMP9KfpEdBppCyYOdaHQ4DQMeSNZcIXJziBiAJ+dTfUIHaRUfypgpiomdstTTeLyfvxAptLPXMQF/f08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GWpOuszU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mJ9R/yS4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Apr 2025 19:21:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745868122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YO5xSfRZ5ebwM14pT4QlhcVHgpjwsTo17OmxMSnITnc=;
	b=GWpOuszUrIGYXHQ4cVVg8uRxZzQnYhepkbzlQUaDEcDBxovWzLahlqvJNxgLaxKKFJhFMv
	+xttQ71fXv0kyqZgaVAtiLKpYQmGlWD9oYax6Y2vK77TSk1Cfk6XMQYocuM+fqHPOvnW97
	Bj19NC2SUqkNpq+L/cYE0nB7SIWgqq4urP+Ms2xIuk2PiSHBmTNjm8HRDbSKs4uhfaGQT2
	4B9Z5Td2amF3ft4lzDk99ddIGefUtgPHe28mgAzHNf9beuscHbuhBzfV/OjCsx7W+3NcZc
	zNRCX6UtK3GQWGNzzoZXevJOc2w6fSBtFoUKC6XksnR8CjsTfFJfsHFBjl/7oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745868122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YO5xSfRZ5ebwM14pT4QlhcVHgpjwsTo17OmxMSnITnc=;
	b=mJ9R/yS4O4+wL7UHxb9jgpcB9SaU1kvo5Z0XBlTB2Icca6Z0mpG4zzpQMVcSyeWAbb1j41
	n4nJGZQtpjzwIYCw==
From: "tip-bot2 for Eric Biggers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Use sha256() instead of
 init/update/final
Cc: Eric Biggers <ebiggers@google.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250428183006.782501-1-ebiggers@kernel.org>
References: <20250428183006.782501-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174586811655.22196.14930925796793997721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     c0a62eadb6fd158e4d6d4d47d806109e7ae32e8b
Gitweb:        https://git.kernel.org/tip/c0a62eadb6fd158e4d6d4d47d806109e7ae32e8b
Author:        Eric Biggers <ebiggers@google.com>
AuthorDate:    Mon, 28 Apr 2025 11:30:06 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Apr 2025 21:03:58 +02:00

x86/microcode/AMD: Use sha256() instead of init/update/final

Just call sha256() instead of doing the init/update/final sequence.

No functional changes.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250428183006.782501-1-ebiggers@kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 57bd61f..b2bbfc4 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -211,7 +211,6 @@ static bool verify_sha256_digest(u32 patch_id, u32 cur_rev, const u8 *data, unsi
 {
 	struct patch_digest *pd = NULL;
 	u8 digest[SHA256_DIGEST_SIZE];
-	struct sha256_state s;
 	int i;
 
 	if (x86_family(bsp_cpuid_1_eax) < 0x17 ||
@@ -230,9 +229,7 @@ static bool verify_sha256_digest(u32 patch_id, u32 cur_rev, const u8 *data, unsi
 		return false;
 	}
 
-	sha256_init(&s);
-	sha256_update(&s, data, len);
-	sha256_final(&s, digest);
+	sha256(data, len, digest);
 
 	if (memcmp(digest, pd->sha256, sizeof(digest))) {
 		pr_err("Patch 0x%x SHA256 digest mismatch!\n", patch_id);

