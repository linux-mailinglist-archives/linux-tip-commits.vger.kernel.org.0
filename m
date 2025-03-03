Return-Path: <linux-tip-commits+bounces-3824-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 564E9A4CBBD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FEDF7A30BF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E3F238174;
	Mon,  3 Mar 2025 19:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="grHZt68H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4UbudOrd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C954E2356B0;
	Mon,  3 Mar 2025 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029184; cv=none; b=OcY4McZkkHHHobyZnHXZb7G+ZCGKyqwqAf4YdnCEHJMrsDXveo7gRERhD7KSjP3DG9RnZSj1bp3UzwEi/Y0/3swBxt6fHlIfg+FfMhPFQkGBzK2x+n7WVUL5560G368HmTOFqrd9uhsyKEq4Eg+oROCw4r4DEV42r6FeaBCDRD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029184; c=relaxed/simple;
	bh=T8vdVoPEb3nsphrQfRYHCcdNIRRswfDZeS5idrhYUfM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O3FWn7SYfkeLrgmVk92IFXNIla6Uf+42KczLryackz0mI7Ik0r6MvRaZRW+NfeKUQgIhskfJy8B4roZ/maB80VDVH/FQ67cMIa8bfHWGZyA6/moS2j3Rw9OFj6a/J6VmLahpp/deF3hjReuCaoFWeq408aifrTvFpJOk0q3VnGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=grHZt68H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4UbudOrd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:13:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hI1eYQNB3Ib0BDBlm1K7S7FM+bPqgNaIKwAHW6EhGkw=;
	b=grHZt68HFC3SMA0G61D5RhlWYsPK/2WxErvDExhNsIVOijnZrssNvL7YI3mOCxLmpWlpxC
	Fs3mAT/5Q9eO+AwIBuQ6czILJrxKgBFqXV3yGwUz7pVo4s8WU06sfDM+NDcMQlbKdfvPpY
	CiiJjl14xjXIB2MLtEJ6pQSTxxGYI7TzxIgTASE13Fg7y6MoIsfAfUUGYfGuGnAH/EFdu/
	qrm+IrWFedxDGUQwVJ54x3tRahUPHfP5dwl0qZJXLIgFSNRK/8Ua87nwaZeEmwD9KUSRkp
	sT7akw9Dfaklgszl6wcDKmv89q/FcDNYHXCjudX4BopYB8zmO7JXDs2E4AdYXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hI1eYQNB3Ib0BDBlm1K7S7FM+bPqgNaIKwAHW6EhGkw=;
	b=4UbudOrdoF7euYI4wsnyh7fc8YvNLetZiEhkriqOqLPffY5VuiDXBPGK6zZKZOk2LQzxS9
	5E7HfJWhdpo0EcCA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: Add headers target
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-8-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-8-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102918058.14745.5512602853189091369.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     1a59f5d31569c742da3dafbbb5620901de11a245
Gitweb:        https://git.kernel.org/tip/1a59f5d31569c742da3dafbbb5620901de1=
1a245
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:12 +01:00

selftests: Add headers target

Some selftests need access to a full UAPI headers tree, for example when
building with nolibc which heavily relies on UAPI headers.
A reference to such a tree is available in the KHDR_INCLUDES variable,
but there is currently no way to populate such a tree automatically.

Provide a target that the tests can depend on to get access to usable
UAPI headers.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-8-28e14e031ed=
8@linutronix.de
---
 tools/testing/selftests/lib.mk | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d6edcfc..5303900 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -228,4 +228,7 @@ $(OUTPUT)/%:%.S
 	$(LINK.S) $^ $(LDLIBS) -o $@
 endif
=20
-.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir
+headers:
+	$(Q)$(MAKE) -C $(top_srcdir) headers
+
+.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir h=
eaders

