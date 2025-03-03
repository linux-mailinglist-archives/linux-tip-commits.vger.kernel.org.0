Return-Path: <linux-tip-commits+bounces-3830-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE5A4CBC6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7922F3A1826
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55123C8A4;
	Mon,  3 Mar 2025 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mapVbUfP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ifYVaDvg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE50323A9AB;
	Mon,  3 Mar 2025 19:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029188; cv=none; b=P6QMlaztreWY0igxeOC4A1YMUMpdC0iBdoOXTq8TDAeJgxo/8jLyDtww7+1cIL9IK8+fWEwrrMupOY9Xd1tTjBvF/HlVsm+nr/FhklrQ8hoaOaWxEMcdGKI2K+P89vVP/DaYeLowun4Fel1+3yG9mqnyCiatfnOqDx++ghEG5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029188; c=relaxed/simple;
	bh=s6imX04ueDapLxj3P7tF6CT+ZYzHNk/8eVAkfN1Y9Po=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aW9yxwmT1D7vLzc8mky3DQtmSfzcxDmv5brPZ+PGi4lfYRy8xRMwSYAeKfksDmZd67r/QoTsfI94U/H/xP8jZYU3p3G18dW6xdIPzVUpG9p3Rrw/AWlh7YlpXGrdiowbFX7RZRRyITRlWNOoEtGl+kWgYNoZGcQS07OVWNsR/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mapVbUfP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ifYVaDvg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:13:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yoO4fTtYS/KrEHI9bv+Otz0yThmR8xMu6lq04gslgKg=;
	b=mapVbUfPsPG6rPyKQ1xDzQbzvsca1uytEf5qSZZX5hm85X43W5vnsaSNBk4Z4ouhGI4ryq
	Cyxo62IkouVTQwH/T3qHIXBOu8RtQ6AKt5F3UWJ0mbvLn9TEqF3B/0LC1S/CvgYWZKIRjH
	Dx7Vr44pTgiInGvfMQAGu2Fo0flrerFIthFLWCgcs23FuedZfduVWcEllURznM5DTSfwJE
	IgAjR5ES62p8FbQoJrLwY18KipefJkWPoCTTNylJYb04VxnWoJWT07wcQN/tGeZOjURbgq
	k3YAnKZJ+Z/x5FmCCqQe+kxS1UmtBbQd5a00YgPTCVP00N0QaZTstaTgeotF3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yoO4fTtYS/KrEHI9bv+Otz0yThmR8xMu6lq04gslgKg=;
	b=ifYVaDvgzrZeK4KM6ssTCwBomGDoiiiv3FudcynaxAC0jOyD5wPzwjOVnapvj1Aw9Np5t1
	vfJ8esinyuZvdoBA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] elf, uapi: Add definition for STN_UNDEF
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Kees Cook <kees@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-2-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-2-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102918481.14745.10736641214443707888.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     c4131140961b93883e69a01b09f8ed4bcebefaf1
Gitweb:        https://git.kernel.org/tip/c4131140961b93883e69a01b09f8ed4bceb=
efaf1
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:11 +01:00

elf, uapi: Add definition for STN_UNDEF

The definition is used by tools/testing/selftests/vDSO/parse_vdso.c.

To be able to build the vDSO selftests without a libc dependency,
add the definition to the kernels own UAPI headers.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://refspecs.linuxfoundation.org/elf/gabi4+/ch4.symtab.html
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-2-28e14e031ed=
8@linutronix.de
---
 include/uapi/linux/elf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b44069d..448695c 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -125,6 +125,8 @@ typedef __s64	Elf64_Sxword;
 #define STB_GLOBAL 1
 #define STB_WEAK   2
=20
+#define STN_UNDEF 0
+
 #define STT_NOTYPE  0
 #define STT_OBJECT  1
 #define STT_FUNC    2

