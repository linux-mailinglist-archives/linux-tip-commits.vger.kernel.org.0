Return-Path: <linux-tip-commits+bounces-5969-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4719AAEFB94
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 16:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E164B1C01934
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1552C279DA1;
	Tue,  1 Jul 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d4ENV1nB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yXycmXf0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4FF279795;
	Tue,  1 Jul 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378361; cv=none; b=SDfYS1rPD0mdSnRXoHEnECbVJxVRegEqj0zrNk6op6j9FpmEo0BVa5Bo38ryvI0Hu7lVyTc0LuzzW0fv4irlf5WYZTTkF3ukCmb65s0K+b8+3307257it8C8pJRwzyaFo9IAlJXcWtRBPZhN/RTclKkGTpUV3F3QYDj1ZSWACTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378361; c=relaxed/simple;
	bh=z3jGUF+hlfK64oKEj0k+B7ETSqK8qO2BwbZmTLRQDI8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jq5jwF+76R/Xpw7ZarVAmNINOvbcyEgOH7CD+DdREdOB+sTiRdSbW5sd9vdo/3BFUUUVPOAwr5LDyJF0//N8zKM0YP/y4+VBQwMmqjTa7QlHfRka83TWOohPp5vEgF9yvd1o6vu1I46V1xSHsi61QxviMbs8Qi4IFqTheORr6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d4ENV1nB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yXycmXf0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Jul 2025 13:59:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751378357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gF5a91yKWuSrwiCkj2xOXY8tI1SZ0SsiXpEYbOYYeY0=;
	b=d4ENV1nBKpoUPrVEmo2eicK+LNP0bgVxo4z/7BCL47dY0hSrdaapPACnpQk9S3f9oPHj3q
	yP4Qym8YLpG0ScXY6tU8cZdAjUnHhhmpdcJP8Hh4oTeWEo22S7U7Ch+Vj8Th3IuddqyV+1
	ymdvr6g4DMtNdyISEjCkhxuJvo/0WgcAxrx3fA4SpBsX1b+TB+TSvMbUWvBCMQywz2uhEA
	pM8NTQH+D+jL/B0rsAu0ojmXfmg4EX4VC0N9D2Hf70zwanBPWxkdW0YTTGpsb8gwh7wmLg
	JNcjU1/bPRLNcRMlqI2a2JcILd1ezhIudQQwWm7gDNkTT88wzmnXNLbvrtxniQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751378357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gF5a91yKWuSrwiCkj2xOXY8tI1SZ0SsiXpEYbOYYeY0=;
	b=yXycmXf0W7uvwDSB74LbKHNHxyVgpgbGUNssxynAUAeWmffygGeQjodAsHyC7ZEakXWgJx
	jX/u0Lz6gQWIJsDg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] selftests: vDSO: vdso_config: Avoid -Wunused-variables
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611-selftests-vdso-fixes-v3-5-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-5-e62e37a6bcf5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175137835681.406.16443304893682610477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     ecabe99a0354fcfa237b75d72a2707b3ace3d5e9
Gitweb:        https://git.kernel.org/tip/ecabe99a0354fcfa237b75d72a2707b3ace=
3d5e9
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 11 Jun 2025 12:33:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 01 Jul 2025 15:50:42 +02:00

selftests: vDSO: vdso_config: Avoid -Wunused-variables

Not all users of this header make use of all its variables.
For example vdso_test_correctness.c does not use "versions":

In file included from vdso_test_correctness.c:22:
vdso_config.h:61:20: warning: =E2=80=98versions=E2=80=99 defined but not used=
 [-Wunused-variable]
   61 | static const char *versions[7] =3D {
      |                    ^~~~~~~~

Avoid those warnings through attribute((unused)).

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/all/20250611-selftests-vdso-fixes-v3-5-e62e37a6=
bcf5@linutronix.de

---
 tools/testing/selftests/vDSO/vdso_config.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selft=
ests/vDSO/vdso_config.h
index 722260f..5fdd0f3 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -58,6 +58,7 @@
 #define VDSO_NAMES		1
 #endif
=20
+__attribute__((unused))
 static const char *versions[7] =3D {
 	"LINUX_2.6",
 	"LINUX_2.6.15",
@@ -68,6 +69,7 @@ static const char *versions[7] =3D {
 	"LINUX_5.10"
 };
=20
+__attribute__((unused))
 static const char *names[2][7] =3D {
 	{
 		"__kernel_gettimeofday",

