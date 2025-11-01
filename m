Return-Path: <linux-tip-commits+bounces-7164-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42475C2877C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1EBA4F61AE
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E82314A89;
	Sat,  1 Nov 2025 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5bTmMxK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7VBevCRj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7F303A07;
	Sat,  1 Nov 2025 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026498; cv=none; b=uOO/g416P0r3pRcSqAfthZGMbId6B69TOE3L7YbFSMa2pSal8xvf7UCWzSkoXwN+3jhORGmmfSd0dxQmfvq/aBJIRAZvIBMe/1n4/lDe1FcqA0VmNL3jlnJcau9j0z9tZdVodwHOXgf5YYOGkwhPle56680K18H6olSkQ8w2jaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026498; c=relaxed/simple;
	bh=3EXNIGFBdVteKg7101utPAdbK6/J3wDDRks5LiRYrMY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KVLzT2vtRzdbzg43Ic8nxfNHC3vUy+8fnm+UiV1Xf4B0i4zs2XKZKvplIVx2H+YlU2uBn8CjT7N2EbHRnMsO4p6wlBzziOgfNoOj7iYl3XTA9i/rWSb/8ynPLm1W7ySkCmfdvkes+8YXdi7/Fs3IC4vUCdXsOFCYjKdQu78XVNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C5bTmMxK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7VBevCRj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:48:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1Tj+NYYyY2WLEqGSjTkn5jgag6pwxkjIO0OVcLtnFE=;
	b=C5bTmMxK8q5b62MuvBEL+MHhJc0b9vwhfR/NChLDY0Af9+lCboeee3xXD/UH7z890z5G8z
	umpjpJ9jBe3MHTw0AGTquTO/vOrhPaj5y9AlP9rOE5taxX0VEi5NR1lcXKR0dbgMffXa4o
	zjDN20LbWCMOn7LeP+hjv6oXv9Lc2Vg421ux8HE6Rwy/OLJ+yco6qbba0TbZANxV4kYrdi
	ybNkTwlWTynlkNCVKBT4NTElHYMFGRmG9xs0dvyZeNq6Wwt+CVw/yE9wJcQsmvL1m03Utv
	Dbc7uBRpA5DC01ykdBKw9DdYaDTAYiB+7gKd2hgtUE9k9wO9rKudhhzEx0Z3ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1Tj+NYYyY2WLEqGSjTkn5jgag6pwxkjIO0OVcLtnFE=;
	b=7VBevCRjrtpEe30dQsFjCm6dvsjKycmogjIRtVQ/6/+raByMLcfkced0gv4mPFs1WL6/K7
	bl6bGsya+OkykADg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] arm64: vDSO: getrandom: Explicitly include
 asm/alternative.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-2-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-2-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202649429.2601451.5811044681165468757.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     cb1e229bb096bc212cda557a0aaa9f2498dea3d9
Gitweb:        https://git.kernel.org/tip/cb1e229bb096bc212cda557a0aaa9f2498d=
ea3d9
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:48:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:02 +01:00

arm64: vDSO: getrandom: Explicitly include asm/alternative.h

The call to alternative_has_cap_likely(ARM64_HAS_FPSIMD) requires symbols
from asm/alternative.h. Currently this header is included transitively, but
that transitive inclusion is about to go away.

Explicitly include the header.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-2-e0607bf49=
dea@linutronix.de
---
 arch/arm64/kernel/vdso/vgetrandom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/vdso/vgetrandom.c b/arch/arm64/kernel/vdso/vge=
trandom.c
index 832fe19..0aef124 100644
--- a/arch/arm64/kernel/vdso/vgetrandom.c
+++ b/arch/arm64/kernel/vdso/vgetrandom.c
@@ -2,6 +2,8 @@
=20
 #include <uapi/asm-generic/errno.h>
=20
+#include <asm/alternative.h>
+
 typeof(__cvdso_getrandom) __kernel_getrandom;
=20
 ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags, voi=
d *opaque_state, size_t opaque_len)

