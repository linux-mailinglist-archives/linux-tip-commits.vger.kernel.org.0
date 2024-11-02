Return-Path: <linux-tip-commits+bounces-2713-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B0C9B9EAB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86881282D49
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9468E19597F;
	Sat,  2 Nov 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tTiqN/F0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PyJEXhP2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A5189BB1;
	Sat,  2 Nov 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542220; cv=none; b=UGY0jJTnWR1V2pPWbwi1nAofnKqvV62r9NEpKX8GXoZiy/W+XkBUzOM/ML/cof04AXuw+kScUVbR32y2zLnaKXZNFwt5vOjAH0f1RysabA2S5XSkvgnotwrxOt51k2B/A9lJueb1w1AWllMxYAlG1FlJ2G2HJNf0olJkmFAw6WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542220; c=relaxed/simple;
	bh=A0+zKmiE4WouzRg98VBl71itFRq0Jcvq5wXh1yuOPRg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HffjobvG1cb4EAiSg4Ae1reemRTVuIvVuWVzbdS6Oghili5o3Vrhyo+dNhH0mGDaaqrXIT/Wn3H8xGRJv6gnvxfZhoeJy0P5l9H2oAeC3i2G+mnbkn2u14UN40OPQvnLKyOMUs2A56WnkzE7qEgJhqscqg/DWw4MlpE++oxKHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tTiqN/F0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PyJEXhP2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lx8j2IG+CSM6UU05NyJqZy2Z2Ix2oy6V1C7P2M5s21w=;
	b=tTiqN/F0LiV2DgJzARo3VSshsXOEKaofVqOhfNMQA3bprwoqT9dNfQnNS10ICBgADkvO1B
	b3hR1n25g/90ko2HGfJyMb7GfVy/iUYcGyK+pHvqVeGzkAEPH7X2JF8yirbkpDJO50QD0M
	s3VCiXetx5N83a2zRSfNLdmjWtOJYisJpesRw+1gXBVZHUYsJK55OR3d8nU9Y8/CCy63Tp
	N2tsXF5lDxni90cJlJsgHUjW7VAuW7G8xIWcCrpQ25w61mukxl4bcVzahH5yzm1+7bsEhU
	Ub1yHzmgYkWoCMvgKAPaEA/fKhiWKgOS1Tj7QQsxmTwQkHLaQfAWR5UCqix9fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lx8j2IG+CSM6UU05NyJqZy2Z2Ix2oy6V1C7P2M5s21w=;
	b=PyJEXhP2yAbbSZA1l906M0u0SiNf9EhCbkvU/8uur70E3Jdy3kMQ0XhaDArJwzTMqAO+vx
	zpxUCUQTzsJjU5Dg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/mm/mmap: Remove arch_vma_name()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-10-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-10-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054221461.3137.6761209442761233031.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     bd6b150d560e385d37c2a29b0af8501fd24b7df1
Gitweb:        https://git.kernel.org/tip/bd6b150d560e385d37c2a29b0af8501fd24=
b7df1
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:14 +01:00

x86/mm/mmap: Remove arch_vma_name()

This function does not contain any logic, delete it so the equivalent
weak definition from kernel/signal.c is used instead.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-10-b64f0842d5=
12@linutronix.de

---
 arch/x86/mm/mmap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index a2cabb1..b8a6fff 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -163,11 +163,6 @@ unsigned long get_mmap_base(int is_legacy)
 	return is_legacy ? mm->mmap_legacy_base : mm->mmap_base;
 }
=20
-const char *arch_vma_name(struct vm_area_struct *vma)
-{
-	return NULL;
-}
-
 /**
  * mmap_address_hint_valid - Validate the address hint of mmap
  * @addr:	Address hint

