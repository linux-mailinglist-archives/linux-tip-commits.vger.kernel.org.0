Return-Path: <linux-tip-commits+bounces-5972-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CF8AEFB9A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 16:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34409188AD36
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 14:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E85281368;
	Tue,  1 Jul 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XDHAjEvf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SASOs6HO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CDA280309;
	Tue,  1 Jul 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378363; cv=none; b=MP9d0eMRDh/amqHPGMDc4nicij7HBrM5XsdZYdOgCkd6rTmLu/UU3NKEZpI4J1aPpTbc0DvFTZGKKJr1weMFbJwHv2SgAm4lzpAXqVea0NS19WB6SXLqzi7zqHxMxb9/JIWWu3XIw2ge+ddmqbgn64pBtgCP6mP8PL7Ob5Ag1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378363; c=relaxed/simple;
	bh=1LfN2ADE5AgYWHebAoZcd0nFwI5oHOmqK41D7M9bXWk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o4/xN0gViQwWDaParITe2z9RhWvLrudsCu82eNAh421qWzCeSLLVqbZ2PHGKcmcH29Dbywi0Mybnhqaa7w2bHJ2nEgWQ7Dpne82eAICLRk79ByurZB2q7cY7RsiwPEQpfKNEvAi7Cz2dl4zloocWJcXKaVCsQQzifE+vhdAfNTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XDHAjEvf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SASOs6HO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Jul 2025 13:59:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751378360;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Asd0+3MzokybgxqD9D1mtZBJmELE27nH5ZZkRhMfwq0=;
	b=XDHAjEvfVxU32QgLtHcrhYzTgYkBtVJpI4fEKufF1prD1fgEIneJY5024lOiG6Dfm1RZmg
	IG6ookmC8cUkTffMnZmD1qjtwoRcg3UiEVffRP34VB0EVBVGucWGvOB857hcdvpv4D3tkz
	aEV75UPlPuy625S+9gcXkdCbsiOAH7cJ1pn9z1qI+b7U96fZ37iBlYEmNOJ6G7sIct/woJ
	b7wzdlla1lq1oydCqEqKp6jiF8MG/8zw5Ok68aqwuq8hdYPWDbm8uy0Mb33DlNVKOpSMlj
	42zKN84C9rOt8FDWcWF6WKeWNzTMS011DkWShucRCRPzi0Rg4lsXXRO98D5UFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751378360;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Asd0+3MzokybgxqD9D1mtZBJmELE27nH5ZZkRhMfwq0=;
	b=SASOs6HO6jNYUTYFXBGqMuun+qFgDZLdDyMN9qg9uu8C8wuK9+Nq6bC59BNGXST7jlmxCA
	sKSGMc8JwwwlQUDQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: clock_getres: Drop unused include
 of err.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611-selftests-vdso-fixes-v3-2-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-2-e62e37a6bcf5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175137835943.406.13370662736620355400.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     82669e157bd8abeb08d19c6d597620585ece576a
Gitweb:        https://git.kernel.org/tip/82669e157bd8abeb08d19c6d597620585ec=
e576a
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 11 Jun 2025 12:33:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 01 Jul 2025 15:50:42 +02:00

selftests: vDSO: clock_getres: Drop unused include of err.h

Nothing from err.h is used.

Drop the include.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/all/20250611-selftests-vdso-fixes-v3-2-e62e37a6=
bcf5@linutronix.de

---
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/te=
sting/selftests/vDSO/vdso_test_clock_getres.c
index 38d46a8..b5d5f59 100644
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
@@ -13,7 +13,6 @@
=20
 #define _GNU_SOURCE
 #include <elf.h>
-#include <err.h>
 #include <fcntl.h>
 #include <stdint.h>
 #include <stdio.h>

