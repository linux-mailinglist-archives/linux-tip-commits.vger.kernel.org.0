Return-Path: <linux-tip-commits+bounces-6927-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A43BE2A15
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177E7582F4A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D38340D82;
	Thu, 16 Oct 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RrGAfnjj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5KyF5hq6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E21B2E0921;
	Thu, 16 Oct 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608421; cv=none; b=FjUPxTWwaoaU7Diu0Ug/CQm3+WnuRCal/3fqEUJqE2XXc1VAF5AWDgYtm8aX5MMbPpvumTas0cReCrsGKYpURhC7hzefYMNYbl97nePv4GXWZgA0ks6bWrULwFUcIZecsls+1QDT+FdgnND7ibXcrD8V0UorwdysvroZc8hVnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608421; c=relaxed/simple;
	bh=ptF6W4i+ui6Ic7O90USJLIAIpz0XkBmz9hPVhNjGHIY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Bx309zfoPUJsxtrO9hAIZR10dXH5W5CiG07KFHzY5IN3A1GfCuVSUH4RdhyniOYOMk36Bb5T+SdQ2cNn8SxCyVepHEgyafoIOEyZvGAEjLy7yR2+uVhccPLbNVGP0oeIR3ZPR1D4tfjnqH6Mmxbhx1v2izeP/RwkDA0l5Cdo9XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RrGAfnjj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5KyF5hq6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=v8xG7PgDo++KZQJGjs+3V/IzK6o9zdnFegcgrjX3xWM=;
	b=RrGAfnjjJB21JDw7lnDXwKUWEx+h5Q6nH0zpR5o21ORTz8le1alcA3fbcMDANAD7ZUlxfO
	sm3LikRzwjLY0b8Cxwi2scMwmHqbGa66BtBZUAnIc/Ft8EFuSVo4UeTwa72QRlHC4vjZ8a
	UAiaaxRxPUN4TROOnfuAZ7db7O62i8o42CLHHA06gJ5egvBXY8UHxOgGaJWKxdh0H/9kH1
	a+1fwcoN7eyMc7ygml3ewy5g1JnG356IqOBE15Hi/4tWNoI8EEGdjrKngQidyup3/39mAT
	AAU+4xDbWcP795LEsOAJBVwbzMWtih7ggevSVftZgd9gUvU0caugkrk33dM/Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=v8xG7PgDo++KZQJGjs+3V/IzK6o9zdnFegcgrjX3xWM=;
	b=5KyF5hq67TIsU/VkBbMX+4yawTO4huzr/IxuW/OspHsqdThc6mFYO6uC2orDcXeMZiYDzX
	9uWitF7DATMvlzBA==
From: "tip-bot2 for John Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] scripts/faddr2line: Set LANG=C to enforce ASCII output
Cc: John Wang <wangzq.jn@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060840395.709179.15771055064700527810.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     567f9c428f99560fe14e647def9f42f5344ebde9
Gitweb:        https://git.kernel.org/tip/567f9c428f99560fe14e647def9f42f5344=
ebde9
Author:        John Wang <wangzq.jn@gmail.com>
AuthorDate:    Fri, 28 Mar 2025 15:38:02 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:20 -07:00

scripts/faddr2line: Set LANG=3DC to enforce ASCII output

Force tools like readelf to use the POSIX/C locale by exporting LANG=3DC
This ensures ASCII-only output and avoids locale-specific
characters(e.g., UTF-8 symbols or translated strings), which could
break text processing utilities like sed in the script

Signed-off-by: John Wang <wangzq.jn@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 1fa6bee..1f364fb 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -76,6 +76,10 @@ ADDR2LINE=3D"${UTIL_PREFIX}addr2line${UTIL_SUFFIX}"
 AWK=3D"awk"
 GREP=3D"grep"
=20
+# Enforce ASCII-only output from tools like readelf
+# ensuring sed processes strings correctly.
+export LANG=3DC
+
 command -v ${AWK} >/dev/null 2>&1 || die "${AWK} isn't installed"
 command -v ${READELF} >/dev/null 2>&1 || die "${READELF} isn't installed"
 command -v ${ADDR2LINE} >/dev/null 2>&1 || die "${ADDR2LINE} isn't installed"

