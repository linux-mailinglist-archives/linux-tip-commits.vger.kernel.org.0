Return-Path: <linux-tip-commits+bounces-4415-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3E5A6B59A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Mar 2025 09:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A693B30DA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Mar 2025 07:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E3C1EE02F;
	Fri, 21 Mar 2025 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ceix2xjb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WCjMGyiZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F931388;
	Fri, 21 Mar 2025 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543994; cv=none; b=RBVaqNRymKX6HQ7A8G3bD2g6PnjGnOR6HVBtNIS86Zxm5y1K3KSgfNQS1z0m6u9LZ5NRCAhF+6Eeu1F73BvXcdPsdKYsoOX08ig3Ek+KsSopYYoPr1vxBchmuxNCe2a2CDh68JGQV4Jgpaeg7rTG06ao2L7GK5bMr1lGjY2Z2Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543994; c=relaxed/simple;
	bh=NYY8m+WSCO0Yzx7ouZbYAadnDvTXW3s8GTLb0ad/kqk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=cPFJ9tSYZP+gguHP7VYg/A4AWUA2b6m1Tavt9Q6mqePW1qG9ouz4UnViXRaVo0lrsHR6PK+wkSyf8FDmXYPwskkKYajspGWLMIR2tZ6mHvIrJ5mTvwvPhD8r3ZDIJ8QrxgFenpN0OllWFegpgqXgFL1DAyGTBjxUo5qNn6qvXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ceix2xjb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WCjMGyiZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Mar 2025 07:59:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742543990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8zezIZtAMtnI/8gCsAimUqTnX18IyTgRvpJrjmnGM64=;
	b=Ceix2xjbQjRz6fyBb1uWVsbyw2/J3LMNjQ8VLg3/K6sWLHkzDkakT/nw5u6A7NrRkKtgUk
	F/PI8qwVLKu3IR2gtYE5Tcd7ftps3Du+/p8VlpixlOhL71oLZp4wPMBAtvFwDvfbcnskyC
	WlPZ/zsWplbpbTyDvkTuf+rtBP8L92jC5pLjv0HEjBZJHGiF0ivI6fkokuGmPMBLqm6t7O
	5gzN4TaS4p6K++rgPmBqaE7+m2Q7WHusaIkK711IRnk7zfwpZnc9foyvjIaioOE/Cml89V
	GHw5ioXrrFpxHtCp4/yYIvsKw4tRsiHpaJPOO8UkL0UJCr3ky2tQRUL8QNanHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742543990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8zezIZtAMtnI/8gCsAimUqTnX18IyTgRvpJrjmnGM64=;
	b=WCjMGyiZzVmEokBNBycam6GLX6c5H0XxfGT3x8GcWszC0NlljEMVp4r6u3WCBYNYMjG0Yd
	WHltvFggmWd0b9CQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] zstd: Increase DYNAMIC_BMI2 GCC version cutoff from
 4.8 to 11.0 to work around compiler segfault
Cc: Michael Kelley <mhklinux@outlook.com>, Ingo Molnar <mingo@kernel.org>,
 https://lore.kernel.org/r/SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org;
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174254398939.14745.1644465295513159567.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     1400c87e6cac47eb243f260352c854474d9a9073
Gitweb:        https://git.kernel.org/tip/1400c87e6cac47eb243f260352c854474d9a9073
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 21 Mar 2025 08:38:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Mar 2025 08:38:43 +01:00

zstd: Increase DYNAMIC_BMI2 GCC version cutoff from 4.8 to 11.0 to work around compiler segfault

Due to pending percpu improvements in -next, GCC9 and GCC10 are
crashing during the build with:

    lib/zstd/compress/huf_compress.c:1033:1: internal compiler error: Segmentation fault
     1033 | {
          | ^
    Please submit a full bug report,
    with preprocessed source if appropriate.
    See <file:///usr/share/doc/gcc-9/README.Bugs> for instructions.

The DYNAMIC_BMI2 feature is a known-challenging feature of
the ZSTD library, with an existing GCC quirk turning it off
for GCC versions below 4.8.

Increase the DYNAMIC_BMI2 version cutoff to GCC 11.0 - GCC 10.5
is the last version known to crash.

Reported-by: Michael Kelley <mhklinux@outlook.com>
Debugged-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: https://lore.kernel.org/r/SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 lib/zstd/common/portability_macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/common/portability_macros.h b/lib/zstd/common/portability_macros.h
index 0e3b2c0..0dde8bf 100644
--- a/lib/zstd/common/portability_macros.h
+++ b/lib/zstd/common/portability_macros.h
@@ -55,7 +55,7 @@
 #ifndef DYNAMIC_BMI2
   #if ((defined(__clang__) && __has_attribute(__target__)) \
       || (defined(__GNUC__) \
-          && (__GNUC__ >= 5 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 8)))) \
+          && (__GNUC__ >= 11))) \
       && (defined(__x86_64__) || defined(_M_X64)) \
       && !defined(__BMI2__)
   #  define DYNAMIC_BMI2 1

