Return-Path: <linux-tip-commits+bounces-2169-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05DC96D25D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 10:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EBD2889B0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CF9195390;
	Thu,  5 Sep 2024 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TRLUNB5h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jMYN1OmS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26921194C9E;
	Thu,  5 Sep 2024 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525519; cv=none; b=iysakQJv9377IHzpvxMMfN0KusqigUZipX/mSyE5BaYk61uD48b/pgxbZCGSbS6VSwGeFxRP5ghat7KLdM+BV/DhCq47h/CsctjADvYiSiCenM1NDJwX941UxWxVs/Q+majjlO37qNQEMTLxJEIkzVLMnFZa9DeVvmr0XHpQhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525519; c=relaxed/simple;
	bh=YAF6x5FgIydFDnIOSKus8zsY7Gkql4p7Ne6/u2z3Um0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WJeLOsbh769Le2lEg9Y61fWMfUy3homEuAXa4n8bbirSTXGhclvTbR/8idBuDP1NG5qLZiGvuEKkcjYSzIzOuyYO0nFsb2+udXuKPzhGOh3WP7ATjI+U2V5Y1evaOVCnHRI5yVtqH8qa4/3LXGFaFaeoQ/S/Z2M1t+/w3HYTzQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TRLUNB5h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jMYN1OmS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Sep 2024 08:38:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725525516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQjpQBWDZiXVQcALAXejZv2kD0nkSGsclo46d2OX9J4=;
	b=TRLUNB5hLgaYnqFNvphwd1zszvaxFR83zFng06q1Yl6PBW+dSr+pw/dQ50SqJXiXrLgz3S
	AZtZYgp1ZvHnHyEBn5K0OwEe1q992S2x5jFnTng8IirHBAqw9QKJhukHp4ZmOw3ozO2wGi
	kg5Nyt6gKmbq1rAcYExo9AimYBeci/MnCtMn5vOSemk8m9SKQhnmFfZFGc+ySGwKPuJzGB
	uOziyHG5aMSONm2nNIv1IiZ+AivG6ZVLTHEVHCc4bfjxx6Dp6jp66lt94dhX3Izsr64Bzy
	Uzq9ZqXDLVCmVLw1/UPFGr8LxtpJ9d9uRTrFQKcWQ7rKd1r8EnJgZIhl2iee9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725525516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQjpQBWDZiXVQcALAXejZv2kD0nkSGsclo46d2OX9J4=;
	b=jMYN1OmSmCxBur4BrqHEBJR1hzGUPANJbK7KBij/BVMjzbh9vcoBpDzfJBwNt+5XXnlVoD
	PoGxUWEn/MJWtfAA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] extcon: axp288: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240903173443.7962-2-tony.luck@intel.com>
References: <20240903173443.7962-2-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172552551612.2215.7307991130144265948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     171a7d9563a07a5101cc536932bc4db88a53374d
Gitweb:        https://git.kernel.org/tip/171a7d9563a07a5101cc536932bc4db88a53374d
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 03 Sep 2024 10:34:41 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 04 Sep 2024 17:58:43 +02:00

extcon: axp288: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240903173443.7962-2-tony.luck@intel.com
---
 drivers/extcon/extcon-axp288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index a703a83..d3bcbe8 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -108,7 +108,7 @@ struct axp288_extcon_info {
 };
 
 static const struct x86_cpu_id cherry_trail_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	NULL),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	NULL),
 	{}
 };
 

