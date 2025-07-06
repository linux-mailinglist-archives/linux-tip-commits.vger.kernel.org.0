Return-Path: <linux-tip-commits+bounces-6004-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8321AFA3FC
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Jul 2025 11:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C2F17C286
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Jul 2025 09:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F91E9B31;
	Sun,  6 Jul 2025 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R8+Wk8LC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MbUicUhf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828FB1AF0BB;
	Sun,  6 Jul 2025 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751793844; cv=none; b=YgprTHHlDebq2/cWRP9pqvdsuzWusM1+A6scZx6D2aTCPM7QPYm7BKh4HfdF9qKMCwC77QTu2gJC8VQ4Ez5J9uXrE432HzGBZFtPWjw1C3C0iPJgNvFOhb2DH6o7OivgbaIW7ieWQB3gGsKVZLZAayC2w6i5VOjuVad+8hJSM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751793844; c=relaxed/simple;
	bh=3S00bf7MYRBkx9VJBBONI3ao5iEjTGNzsYW8izN+F8I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u0tk592rbB5XIgfVGkmh+97vnwhDn9XkdUb+42XrnasKlSqzNxCNmWIUd5mus8pCHQu5xsOAWooeZ1my9jMu2rc73cHJp3RmQB9vv2dUEn4gSjQ3l/aX7WSwOV6SRNczoHFwek0oMH++GdvpTm72ZGig5Km5pXrg6ZFwFnf/zZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R8+Wk8LC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MbUicUhf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 06 Jul 2025 09:23:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751793840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRMEDV04RgjWtKg/Np7/cZYM1u6WmmpRsdbX1AIk2vU=;
	b=R8+Wk8LCnMO0xqOTkx3w0kLfYINeIgiTlc44ucaMt4aCwpyqSRjLmSrheMuUK+3Y7ZHmvP
	SJHbdxtr5lZMES5rormSjnmOpdJ+e1nYKjDRnWAwW6DD0U9YZMcFByFB7Lctc3+KKtyppR
	jyyw618QKaxxy4m8LCv9ug7RCLO2JSRdihF8f+1ItGuiGoMBEBdo+oxy+gugOH+6wPBDZ2
	I1jLlUKOAqUwMU7Wm7ogocK9LEHN7TOlp2M6oK6ZGZC149k7BSOIAEpJNOvOYvhsMDHao7
	jVOPPFK3I3Z5DB3Bs97NUve6DjdkMgojbikZCB317F1pAjRhqYmN00GUpgUBog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751793840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRMEDV04RgjWtKg/Np7/cZYM1u6WmmpRsdbX1AIk2vU=;
	b=MbUicUhfVo6EJHMGwHxRbhE7hTCF8S3zb3KYrWubQztjYNHCO2zyo9BQZspt8rYNLvRiyu
	w0iFXOy6iGhmC5Dg==
From: "tip-bot2 for Terry Tritton" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] selftests/futex: Convert 32-bit timespec to
 64-bit version for 32-bit compatibility mode
Cc: Wei Gao <wegao@suse.com>, Terry Tritton <terry.tritton@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250704190234.14230-1-terry.tritton@linaro.org>
References: <20250704190234.14230-1-terry.tritton@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175179383900.406.10876682854606019107.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     d0a48dc4df5c986bf8c3caf4d8fc15c480273052
Gitweb:        https://git.kernel.org/tip/d0a48dc4df5c986bf8c3caf4d8fc15c480273052
Author:        Terry Tritton <terry.tritton@linaro.org>
AuthorDate:    Fri, 04 Jul 2025 20:02:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 06 Jul 2025 11:15:29 +02:00

selftests/futex: Convert 32-bit timespec to 64-bit version for 32-bit compatibility mode

sys_futex_wait() expects a struct __kernel_timespec pointer for the
timeout, but the provided struct timespec pointer is of type struct
old_timespec32 when compiled for 32-bit architectures, unless they use
64-bit timespecs already.

Make it work for all variants by converting the provided timespec value
into a local struct __kernel_timespec and provide a pointer to it to the
syscall. This is a pointless operation for 64-bit, but this is not a
hotpath operation, so keep it simple.

This fix is based off [1]

Originally-by: Wei Gao <wegao@suse.com>
Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250704190234.14230-1-terry.tritton@linaro.org
Link: https://lore.kernel.org/all/20231203235117.29677-1-wegao@suse.com/ [1]
---
 tools/testing/selftests/futex/include/futex2test.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
index ea79662..1f625b3 100644
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -4,6 +4,7 @@
  *
  * Copyright 2021 Collabora Ltd.
  */
+#include <linux/time_types.h>
 #include <stdint.h>
 
 #define u64_to_ptr(x) ((void *)(uintptr_t)(x))
@@ -65,7 +66,12 @@ struct futex32_numa {
 static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
 			      unsigned long flags, struct timespec *timo, clockid_t clockid)
 {
-	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
+		struct __kernel_timespec ts = {
+			.tv_sec = timo->tv_sec,
+			.tv_nsec = timo->tv_nsec,
+		};
+
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &ts, clockid);
 }
 
 /*

