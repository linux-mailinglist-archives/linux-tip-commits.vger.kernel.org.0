Return-Path: <linux-tip-commits+bounces-5825-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED70AD856D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 10:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F51165F2D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 08:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E0126B775;
	Fri, 13 Jun 2025 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1pBw/Jig";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zzTwUHP9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858E7DA6C;
	Fri, 13 Jun 2025 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803109; cv=none; b=iLaKx/8vxZ/JrAq05hSLGWk1YxOxJicrW9v5UDiztcZ7Q9xaiAy2TZrqUIyluw24s1b1UPc8ku8WAufHNBRn3PgFQOdwe8Hac+ep2CNicNKfquPLNRvR0cC6obL71lufYES3zjfyJMa3735RJJZOCJS6wR3z+KCiDjPEFwE5hbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803109; c=relaxed/simple;
	bh=VZLgHFuPORnBQWrjmRLu3uHFQ6kGKetFxcCKF2hv+ak=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TekJRhzdPAgdAc9NdztDZQerSSD0tL1UwrtY0FE1A1FkMqU3xr5lpeFeaQJRgeAZnCWZpBjwG3Yytennf0lZLNB+oW3RUZ7QdtuABaQmmPCfgxw7SYNtVhH2bCSyPL9K6GKohEBQPl1+L7rr5Jflks599qHUXrurMe2u+V5/tmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1pBw/Jig; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zzTwUHP9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 08:25:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749803105;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nVU77R4f78HixzZeDmgyOfZwod4888GGXFoyCrDxmw=;
	b=1pBw/JigF/DexI+gkC+GnQfv7f2BjNmm1KHqBym0lDuYaHutTheXptJOB0DmVfmMnivvxH
	FfvzjyXyyVSTu+WrLM3+WKUTqjZs+jLID8uRiHTf5YNtj1XZuhwNRabizGGiNvwj0j815s
	++QgQChM3OwVYeZJs7a7fxs01RNVGNjklBepD8dsL/crHeMIXJNuZFZx+JYXitltX12SHn
	pHe2lSP3EzonK7OG2+GRyrXO6RHpyaewYrMCHYArxm5DXLF0r1tqXpnt/XlJHzPv2++zd/
	/XqJq/4Rzked0EOI5cn6uV8YDmgjhH6h95NJjuOyUbcGr6bS/GQZ35Ndv6IIWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749803105;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nVU77R4f78HixzZeDmgyOfZwod4888GGXFoyCrDxmw=;
	b=zzTwUHP9hUrYtlRGJEEkTAF5opdkpSYv+tmMWK6R9hKGZPzIWSqHzP9TJ1RC2F4opEASqX
	k4D0w2UmeOKlhTAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kconfig] x86/kconfig/64: Enable popular generic kernel
 options in the defconfig
Cc: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw@amazon.co.uk>,
 "H. Peter Anvin" <hpa@zytor.com>, jgross@suse.com,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, Peter Zijlstra <peterz@infradead.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515132719.31868-13-mingo@kernel.org>
References: <20250515132719.31868-13-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980310479.406.397679644187877950.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     475cf81e4fda88ea1b37b5efdf734084f692111d
Gitweb:        https://git.kernel.org/tip/475cf81e4fda88ea1b37b5efdf734084f69=
2111d
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 15:27:18 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 10:03:41 +02:00

x86/kconfig/64: Enable popular generic kernel options in the defconfig

This is the last set of options picked up from major Linux distributions:

 - CONFIG_UAPI_HEADER_TEST=3Dy

    x86 developers frequently modify UAPI headers during development,
    make sure they get tested.

 - CONFIG_WATCH_QUEUE=3Dy

    All major distros have general notification queue support enabled.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: J=C3=BCrgen Gro=C3=9F <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20250515132719.31868-13-mingo@kernel.org
---
 arch/x86/configs/x86_64_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defc=
onfig
index d9f8fae..09362bc 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -1,6 +1,8 @@
 CONFIG_WERROR=3Dy
+CONFIG_UAPI_HEADER_TEST=3Dy
 CONFIG_SYSVIPC=3Dy
 CONFIG_POSIX_MQUEUE=3Dy
+CONFIG_WATCH_QUEUE=3Dy
 CONFIG_AUDIT=3Dy
 # CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
 CONFIG_NO_HZ=3Dy

