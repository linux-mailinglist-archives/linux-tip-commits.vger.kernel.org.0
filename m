Return-Path: <linux-tip-commits+bounces-2727-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A332A9B9F98
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687C128205E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F2F18A947;
	Sat,  2 Nov 2024 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhz9k0Tf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JMZsLY+K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352B189B83;
	Sat,  2 Nov 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548219; cv=none; b=mqdT0SbjGO8K+y6i3oOM20+M3E9EKpJOimmRZchIpI8q41LghB9GNcHJDNa68GXnQbyexU1GxLXZunlWSjbVgbz7jMXaZciezQimqoqHL1dyGrDxQCcLOeikjV6D0ETMeJNtDyr4RBmFhbbpUtmlrQaKJgUF36O3RdNsDzYDrsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548219; c=relaxed/simple;
	bh=l1ZgUYms0g4VtdGX+I4rFJJAhzwg+RpzjIbXZzzEV6A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r3BZylp4HfugW8VS1ebwHnm64vqoqOu+/Uyz5grFacoOt9ZDK0dTzVzenUMUo2WZsAT4XAIlPrSVzKLY68FnRz2Jj9Q9hOo0eGo29DXmsmCr89cVSah2UW5UFt7o1K5g89XZzxQ8gCgztqhm5wzNgJPvKGn2eSDQp9MxJM8lclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bhz9k0Tf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JMZsLY+K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZk5elShKdLkHuiwg1Je9U2ZA+1spIGZFJQ6SshQojs=;
	b=bhz9k0TfCM2SDj4pq6vJCxGHDyO9Tz1IErlUVwS6FJmIUrXLSONdm/xeSfvZ+Akn/GRvam
	s7hylnUoCyX7rK8g49T65oBzn52s2Ney8ZVbiu1P1BA7a7Ia6BSU1asQYpyXsjmhFxfseo
	zD2E2AzaH8Z3udvgL0m0icTl13wufvbUl6IDoK535fA01+eDSNiNnmVUOo1v+VJJYXsXFr
	AFvYDUBdg7amobhUZUo6JliMkYOmN+0mCYL6G8cFmvzDiGygU4o5z/h3gB5rK1Bmre7CLH
	HkR+b4tskBrscox7hJOBNCS1mYDn3UZv7RopvnyFLb3bDFQ9eEyAGoop7ER7LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZk5elShKdLkHuiwg1Je9U2ZA+1spIGZFJQ6SshQojs=;
	b=JMZsLY+KKEDGeJzgnZxt0uymvE58VE6r3Zuo4r+Fms735DjCQdWeEh8NtGj4Z3UhD4Boql
	4Nq5x/EtZbahWnBA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] powerpc/pseries/lparcfg: Fix printing of
 system_active_processors
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-23-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-23-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054821460.3137.7715424215341395263.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     af2c15920a114a7acea4dcbf9cd4a7b0ff469780
Gitweb:        https://git.kernel.org/tip/af2c15920a114a7acea4dcbf9cd4a7b0ff4=
69780
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:35 +01:00

powerpc/pseries/lparcfg: Fix printing of system_active_processors

When printing the information "system_active_processors", the variable
partition_potential_processors is used instead of
partition_active_processors. The wrong value is displayed.

Use partition_active_processors instead.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-23-b64f0842d5=
12@linutronix.de

---
 arch/powerpc/platforms/pseries/lparcfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platform=
s/pseries/lparcfg.c
index 62da20f..acc640f 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -553,7 +553,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void =
*v)
 	} else {		/* non SPLPAR case */
=20
 		seq_printf(m, "system_active_processors=3D%d\n",
-			   partition_potential_processors);
+			   partition_active_processors);
=20
 		seq_printf(m, "system_potential_processors=3D%d\n",
 			   partition_potential_processors);

