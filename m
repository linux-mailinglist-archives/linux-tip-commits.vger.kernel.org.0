Return-Path: <linux-tip-commits+bounces-5747-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F1EACDB0E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Jun 2025 11:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8354188F737
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Jun 2025 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D7328A709;
	Wed,  4 Jun 2025 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aFv65hOB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XBajL+fy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0E482864;
	Wed,  4 Jun 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029699; cv=none; b=WA8rE+tYoEreSGOVvLexOr8aNISOaU/EYqY7RzD/Fi6fBdV3oU3L4ANIUtidmvLu3iV7uS288AhQzVjeebZidMOtMUmEMSZPwYeIDE8MhQEGCEOjZEKURsB1MuKLlbGEjeE6MxccwnFa93BiBNTe04xNG3ENWIGJPF+jl/lD4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029699; c=relaxed/simple;
	bh=L9BmflX7GycQRg7YWgJZGNfCIboDcCgIcxkKdu4t52E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=heEJl9tuT18w00nS+MRdsTIvX47SQG4RKQdqw9/ort8UsdMG6rpFO9VorjxC3dib+PVQYpWJJ3aNr7pIoEcKdtDtaVXzjvInqXkzNCSO+R5fxkl3I+Qq4iMvyAS+NjMCKmyDqpJfnMRjlDlJZk5LkSIbt4H4VG/4FE/Cf8IhlME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aFv65hOB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XBajL+fy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Jun 2025 09:34:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749029694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bOo4qKfuuZa6TX/ar5x8qZB7/OezbXS7GYMDyXpGG0=;
	b=aFv65hOBYvN/KeCxsPsi3E9UxSzERZTvCYCbFV+CtAONqsSTUCU8oPbBRTDkOiRKVEVmWg
	QhiNS+zrVAcniN4XLxG1mWzpj88mxWHRis5Opr0Vs3dCLrOebUkAZSLH8ogP9uCYELL0WU
	y//kk8ZO+A+I5rIdnbGg/5+SlsKuUkp9NaIeoRo2FVKjyfkUIVUg73Sqi/cozl76qogHwj
	A8IGxmTBEu8Q6hK+t4TiHSHc+y8CpeD1Ch36NEMhHAsxVJsPbF7iKNV3tvSS/m4Hl2WdDz
	TSrzxEniVZ/PRCI1Fo40HkBbDYA9vqfv+3WvzpDYbKAfSkks6+XKpJu9po5jMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749029694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bOo4qKfuuZa6TX/ar5x8qZB7/OezbXS7GYMDyXpGG0=;
	b=XBajL+fy7drzaIZx2fNDEpcmaN5WsuvwULE/4YORa9LB4E4ohrMiQKvtiMx8Z+vlfJ2wld
	IGsMpTob7DLXJeAw==
From: "tip-bot2 for Herbert Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timens: Add struct seq_file forward declaration
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 Thomas Gleixner <tglx@linutronix.de>, Andrei Vagin <avagin@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aDlskzKIAULMlwPj@gondor.apana.org.au>
References: <aDlskzKIAULMlwPj@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174902969284.406.10485313481998552262.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     434d7f9b0e24e1f0166d05f10881a8ab386845b7
Gitweb:        https://git.kernel.org/tip/434d7f9b0e24e1f0166d05f10881a8ab386845b7
Author:        Herbert Xu <herbert@gondor.apana.org.au>
AuthorDate:    Fri, 30 May 2025 16:30:11 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 04 Jun 2025 11:27:11 +02:00

timens: Add struct seq_file forward declaration

Add forward declaration of struct seq_file before using it in a
function prototype.

Fixes: 04a8682a71be ("fs/proc: Introduce /proc/pid/timens_offsets")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andrei Vagin <avagin@gmail.com>
Link: https://lore.kernel.org/all/aDlskzKIAULMlwPj@gondor.apana.org.au


---
 include/linux/time_namespace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 0b8b32b..bb2c52f 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -12,6 +12,7 @@
 struct user_namespace;
 extern struct user_namespace init_user_ns;
 
+struct seq_file;
 struct vm_area_struct;
 
 struct timens_offsets {

