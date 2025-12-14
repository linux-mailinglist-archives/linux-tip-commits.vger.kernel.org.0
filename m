Return-Path: <linux-tip-commits+bounces-7678-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C735ACBB850
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46C7D304E151
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020B02D372D;
	Sun, 14 Dec 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QwCptQUm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EDBq5dYg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA002C21CF;
	Sun, 14 Dec 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701458; cv=none; b=AbnPlnXQ3I+EeCtIFL/4tQkuQaWbezXjuUdyn1MiEpNi7X/4Br0qdxZdDtON7aOL9ENCsZ1EphhmWEeX4Ir/PVkJsmNkyhrjHh8rtlag0BSjWbAN9BgUH2sAR3GToBrpEzZakK5PPrG5QykM4Qg08BWtE+dd3f1UMpbACBWGd68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701458; c=relaxed/simple;
	bh=dd3gWV6Zlm4M7nliX6gSt/swHtCV4JlJwGIyU32r1f4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OQFhBw7i9f+MWb9FtQ6KTu3K8u66yS06yCv3NdYjFdgmrt4tlmqGipT3SP4wfMT0aAVvS+ROf1CHI3hI64i05ehIATi6m3g8C+Wb5OPiB3DSgEqux+VwdT7LKgrftb3EOxwPhW7xwFjCGMm+wz9uV8dSogQCgjdXGRu/ao1LBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QwCptQUm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EDBq5dYg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701454;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYeq+bbmUut1oMvzUjLYGpvI0dVKJA2zYFZPNlJ7lpo=;
	b=QwCptQUmIyVQ+yHf0dM4uKobn9rsPeXe8Qj9UpsSmRjxrPCHKhel072uzLXBDRskb+cQqL
	M8RR2wose/4rbY+jxwGJx/Fnh6gODUPoWiS+Lo7NVQY1hSshiTX2KXzEYyzLWL4JG61r2L
	pybb/oMtYod9RnGrNL3mz6W9X60N+g9mZkewud8UiDafpExtgHNSIlIDOa7Cesx+DK3aBy
	xJD3jcfJ6ArHMv2AHE+SJO9i64LTPwuWEmVgVosmkrlLtsCJt2aXQfklh+vQy+YdjA0uuG
	UvuBamk/yHGioMsOewJFqsJ5vdpx0XnqJx+mYrXnL/nets42mqTr8o2kOzMnSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701454;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYeq+bbmUut1oMvzUjLYGpvI0dVKJA2zYFZPNlJ7lpo=;
	b=EDBq5dYgj4iQ0J0PtZeU1sbHK8XOFqYyliOun9zl8BoieAH7Sd1032V6g2P2ImJhmJ4/wP
	UP7Oev5fJcmLPPBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Remove unnecessary header inclusions
Cc: Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Shevchenko <andy@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-17-mingo@kernel.org>
References: <20250515120549.2820541-17-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570145301.498.8294757996487539489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     a515ca9664fba4733a95231e5b3e570762b39ced
Gitweb:        https://git.kernel.org/tip/a515ca9664fba4733a95231e5b3e570762b=
39ced
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:32 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:39 +01:00

x86/boot/e820: Remove unnecessary header inclusions

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://patch.msgid.link/20250515120549.2820541-17-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 2ce8ca5..d8fd7c1 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -9,13 +9,11 @@
  * quirks and other tweaks, and feeds that into the generic Linux memory
  * allocation code routines via a platform independent interface (memblock, =
etc.).
  */
-#include <linux/crash_dump.h>
 #include <linux/memblock.h>
 #include <linux/suspend.h>
 #include <linux/acpi.h>
 #include <linux/firmware-map.h>
 #include <linux/sort.h>
-#include <linux/memory_hotplug.h>
 #include <linux/kvm_types.h>
=20
 #include <asm/e820/api.h>

