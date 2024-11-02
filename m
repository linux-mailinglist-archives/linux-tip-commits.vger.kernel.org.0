Return-Path: <linux-tip-commits+bounces-2741-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6EB9B9FB4
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C215CB20CB6
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185DD1AED3F;
	Sat,  2 Nov 2024 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2SpJjuw1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J4In/Xv1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C40D1AC459;
	Sat,  2 Nov 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548229; cv=none; b=py5bqwvBPoowqyqkpsc+09YlyMJgBXtYFsKxddC/RAupL0OMV9jbyqx7DFu3JS/SpnLs4KIMA6hFK3amKdZAjFjZSwhZryQG/Bq6t5cnYRKROUqSBmA8aGFRF+HHdAq6FFm+YpMZLPqj+oJZz+qFWLJ8eezTvICkPeTV1Dz3ZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548229; c=relaxed/simple;
	bh=Yg7DG7x7XmOR3xU2V/4F+YPXKG+sDbtc94zkXXFAgt8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KP6VVR3ieDjFf6wKoINSLkWBQdC8U8WvXhAEOE7aNaPPTYAps9J4UyFvVvn2jX2cJdLHa9G0TUYoeThT75Sywr4BnfPZHlyr6gVkWyFoxm91Ao3Texz4p7wUCu3m5Kv2xKc8nb0vkvPPZtEloMKH2FnoSAAZxOYNZpMHeOWZJVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2SpJjuw1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J4In/Xv1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6FAzbhyhW9WTx69oo3sSk0yq66gWuyegzyLkD09l00=;
	b=2SpJjuw1GcTsI8ZpdAqKVq1ASkxp1d4OmJnyM3LzOrI9gZnXIi/iEUiKpr7lOy7smq8FI9
	6J0o91l94nnzNmVSK0j7fOxVDyVjCNIJbcuYDsnNr7fQe/JK8api7TWGig4GlesNyma1SO
	VZW+xGeKlWA78KMByCvBNNOmMWCXD+ipo6LitiqT8eobcgpay3UpuMSMQzgCusmzf3zNYa
	jKfg0VORd+7FP/CYOONy/IQgloee//bvmQmKPzZCtdaWa1OZqOqlwAYrt3QrZNri/cQvOF
	5lodDNJjKUQkeFgde1rCYkF0+HYUS9iyQ+u6+XIkgKVSWjPlSdpkn2TT+EjUhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548225;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6FAzbhyhW9WTx69oo3sSk0yq66gWuyegzyLkD09l00=;
	b=J4In/Xv1iwg7LL35tIcQEHzbP3xMGth4EbtbcPYWv4cq1bkMsBhPsNOpK8o26jeE+tIFP5
	atpb9lWSGJOOAuCA==
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
Message-ID: <173054822439.3137.11491157183279565025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     f2182dc40a3133fb4308971d164b95d9c405101d
Gitweb:        https://git.kernel.org/tip/f2182dc40a3133fb4308971d164b95d9c40=
5101d
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:33 +01:00

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

