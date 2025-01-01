Return-Path: <linux-tip-commits+bounces-3164-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779309FF3F9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 13:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934B11882516
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 12:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117751E25E5;
	Wed,  1 Jan 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ThIwEJWQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mv89NmUl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C71E1C16;
	Wed,  1 Jan 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735733660; cv=none; b=SXQ5nF8dz4iAF7I1o7QPoOX/NncjzNLbo1oM62sIylF9GqC5ek5sA2mmhzdr5BnBbhMVBQ6NeMsrORYWY+V7ldyYQ6tfxnnZ8MDmyBreVjgz8kwyjhICLOY5FfoKLKFD4Mrk6XsO/fMYn3f4n7IGsHWpiOTkcImL/2HuICA31Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735733660; c=relaxed/simple;
	bh=5Wf3LgwgFAA6zICX1+H3FKIDqGjqi43wvxzhL9tPGJ0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eXr0HrnAADRvI7uRIcv6bEybztxu9e6WnfU7aJD+7auGk30nWaGYdHFptsYgbtLiUga0mc06Gw2YGdZasfDN6hI5FDfOqW8e3E4+rYry0T0G73UssZ3OAd+dHqLZx0j5MdyJ4KW90kLh/EeJSRsuoLgzKEHNV8pVhvZZoP6vHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ThIwEJWQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mv89NmUl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 01 Jan 2025 12:14:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735733656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLce52GM66Bj1I9aewTk8yjE32TuAuMNHmwi4Iy70OA=;
	b=ThIwEJWQh4VHSojqw5fL+xC7MUrBrYdqy2ZogSvgvPsjx4qcBMxSHbFt7ifI3ZzmmujgA0
	NxYYqLBhett3VHQUyOWhPtWPAY+7b5jVKn8eccelulwApjj3LuUyIz336dyzQjvJCpi9pI
	LJwVhiWmoSwrfKdqriMZdMAjZF7FKCiMefnustFZu7r6r5uMjUyW3VVFNMsH4vq2EHlJAm
	oDAdm55lKimMujeEvfIKh8MXd3znG69uy6CxlYEawaTAoJNmHPTpn61tFiGKYT8RtxNaQt
	M1aRNkiOSJ44CCueKGw33SY20bqpV4s6BKTYH8qSOi4n+nlfYfOlAkOn4Z1GOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735733656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLce52GM66Bj1I9aewTk8yjE32TuAuMNHmwi4Iy70OA=;
	b=mv89NmUlyoO7LicY4DlOS5eDAgkjmYVcdBR9PLstu9iucZ8Ta1X/uXLQh2IsvFMU2I1NJz
	fpvThTwVDzkKfPCA==
From: "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Remove bogus comment from
 parse_container()
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241018155151.702350-4-nik.borisov@suse.com>
References: <20241018155151.702350-4-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173573365622.399.9719211836854253879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     db80b2efa0377bf6e7d422fd7e6605481b3a0ee4
Gitweb:        https://git.kernel.org/tip/db80b2efa0377bf6e7d422fd7e6605481b3a0ee4
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Fri, 18 Oct 2024 18:51:51 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 31 Dec 2024 14:03:33 +01:00

x86/microcode/AMD: Remove bogus comment from parse_container()

The function doesn't return an equivalence ID, remove the false comment.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241018155151.702350-4-nik.borisov@suse.com
---
 arch/x86/kernel/cpu/microcode/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index d395665..95431e4 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -381,8 +381,8 @@ static bool mc_patch_matches(struct microcode_amd *mc, u16 eq_id)
 
 /*
  * This scans the ucode blob for the proper container as we can have multiple
- * containers glued together. Returns the equivalence ID from the equivalence
- * table or 0 if none found.
+ * containers glued together.
+ *
  * Returns the amount of bytes consumed while scanning. @desc contains all the
  * data we're going to use in later stages of the application.
  */

