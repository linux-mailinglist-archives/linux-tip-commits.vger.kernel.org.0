Return-Path: <linux-tip-commits+bounces-5971-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAFEAEFBA9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 16:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E7177A80EF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 14:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BDD280CD5;
	Tue,  1 Jul 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YIQMVoX1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AZ1P9jZ9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AAC279DA7;
	Tue,  1 Jul 2025 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378362; cv=none; b=WQnnBuQgZYoYgIo+0w3ccOqSmIE+FNu+FhhrHd6wRKkXTHdZYU3Gxox9keJKlbwbGJlIqyYtQBlq/wRm2jgoszIuzUpDBM8CIhB+7Z+vs/Bk0UwiE5lIRyodJPO58P7zZHbAUKQYlO4nTil5OTwijsu5h1X53/Zwt11Cn9O65QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378362; c=relaxed/simple;
	bh=yNfSeR9EgaTo9XF4lZkuTijC6eVaNuQaZK9SevmLFUk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HznIju3sHh+fW4NYKyqU6fPuYdkq1i+4x7qk1CFO7XMVsvsj34EjnHx0crbllsANgyzmo+F4qKEiqx9o0jxoBB4rFKp5N7N9GiE/LWrJMBOV8JbqFb1WfcSyJ2+yxUW7+c1Pokg1Q9+1snMtWEfzNViGNO1hbMc9y4zJ03aW3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YIQMVoX1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AZ1P9jZ9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Jul 2025 13:59:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751378359;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqKCcXURLDFouaE3IyjlGEXzfPuoWXpvV9DFOPLeCqk=;
	b=YIQMVoX1OSPMJq6PfbxgMGPdSCbAOfxxWDID5HJQchCYs2RUF4xDEjXgrJSJfrfpJ7Sbs9
	sQKAErh3BKgCqMCOi4pjGN4c2zTdWO2TusRErgkeQzl2oIq4P4dE+HGjEK9wer7j+SoUWs
	dc9dF9D/PBYAIfCY2S4RLnmqCPuuDyR+Vx/mxO8qNidcWpNgkTiXBZmjpEDDvhKj8a9IK9
	GldmFLD6346D5Rcq+jMQJ1MZa+w75KRgAAGxzdx6FdDj0Mk5nMm2i2fqW0dWGiZvm+gAS7
	NHO77Bj6iNDhvA1f7tA2TGA87+dGAbs0bn/pbsLb/HgDodYr4rxEzaaki+lGGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751378359;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqKCcXURLDFouaE3IyjlGEXzfPuoWXpvV9DFOPLeCqk=;
	b=AZ1P9jZ9YX49onTIqtBUpEfe7Dao10X+8RhGI6fVP3qJMSO7HzHR3siwYXvFNbsSg99W4c
	SH0hXXnRAMsZ08AQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: vdso_test_getrandom: Drop unused
 include of linux/compiler.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250611-selftests-vdso-fixes-v3-3-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-3-e62e37a6bcf5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175137835854.406.9775899664589081431.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     1c0fe1c7674121bcb233565bba08f7fcc2a8d5a8
Gitweb:        https://git.kernel.org/tip/1c0fe1c7674121bcb233565bba08f7fcc2a=
8d5a8
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 11 Jun 2025 12:33:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 01 Jul 2025 15:50:42 +02:00

selftests: vDSO: vdso_test_getrandom: Drop unused include of linux/compiler.h

The header is unused. Furthermore this is not a real UAPI header,
but only exists in tools/include/.
This prevents building the selftest against real UAPI headers.

Drop the include.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250611-selftests-vdso-fixes-v3-3-e62e37a6=
bcf5@linutronix.de

---
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testi=
ng/selftests/vDSO/vdso_test_getrandom.c
index 95057f7..f36e50f 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -21,7 +21,6 @@
 #include <sys/wait.h>
 #include <sys/types.h>
 #include <linux/random.h>
-#include <linux/compiler.h>
 #include <linux/ptrace.h>
=20
 #include "../kselftest.h"

