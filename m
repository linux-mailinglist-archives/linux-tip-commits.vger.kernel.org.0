Return-Path: <linux-tip-commits+bounces-4113-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75819A5A3A2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 20:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B093A625F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 19:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE119225766;
	Mon, 10 Mar 2025 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qkoSKoS+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6acQyUCo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09036199FBA;
	Mon, 10 Mar 2025 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633762; cv=none; b=UFWOPhnQqCulyiHvnXr9VWomZS+6eGzx8qh7IA0LGYw5tFPWrWDhz+rioqxJRrTbj4WCPkIAy0YKUOhbMpI4fIgcXnAmoSMp9G4XtCTJVDRSRrmNoIqmX1MGiMYsuBkdJlkzO1/VIUamHF4xfSd4A7WJqQywgUT2gdbIY/8VVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633762; c=relaxed/simple;
	bh=iblLPzG3t9kSuK+o/qes9+wshJPa0LXM6J9Pg+F88oY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ppda3m6NqZ0MGFSv2D8Y/pMs+Gd7SgHCG/o4sFuPU8+LOI18roVSNgX1oc/WBH3z82/S587avTl5K3erigA0RwoTTu3hjOn+Rn3UEzNgB+GGGSID7+ZU74GiWZ1hvIAT4pqRekhJuFaY0h9YMHnN9WmrKCzVnmNhL/QW7/Sd+co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qkoSKoS+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6acQyUCo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 19:09:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741633758;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJ/re8by5UcGcB7IbKVRbQ0y9nHtzvymF6WfUZ7lqAo=;
	b=qkoSKoS+9s69FYskOJlTF+4vZgTUBTd2hmKNmMdcagj9R8xdZ4Za7LbkkaC6vuJBsv9yYU
	lYzS8Sw5sYMGDG/4AIc3LIHr2wY5OoRBxUoDEsCLye15NOLCnncTXhfYNUayY2cBsZe2Q4
	cP+BANAxEWaCFtUu9doVTK9WdTLgmaS3esAMbS/gyn1iUa38cz8moz7MarewkIl1aloybt
	LIYekMIz4JVmCwlFDxdB3RNV+NMZyED60HChgu6bynWP58JwZF/pWLL4YVPhfhBgrovv63
	mHT76mnKnRHj5qM2hl0JtaTaM0ZYp7nA84ATK+hvRABFntDivfZHHhhh+JKaAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741633758;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJ/re8by5UcGcB7IbKVRbQ0y9nHtzvymF6WfUZ7lqAo=;
	b=6acQyUCoD/N51LJaOXeTr5B6zliQhqkPL4tyu3bz0r2i2KKiFb+A/koruVJPJM+Ip/ELXD
	7QEeU/ps7/Bwp3Bg==
From: tip-bot2 for Ilpo =?utf-8?q?J=C3=A4rvinen?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] <linux/cleanup.h>: Allow the passing of both iomem
 and non-iomem pointers to no_free_ptr()
Cc: kernel test robot <lkp@intel.com>, ilpo.jarvinen@linux.intel.com,
 Ingo Molnar <mingo@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250310122158.20966-1-ilpo.jarvinen@linux.intel.com>
References: <20250310122158.20966-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174163375319.14745.16922341165556020478.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     366fef794bd2b7c2e9df933f6828dd9739bfba84
Gitweb:        https://git.kernel.org/tip/366fef794bd2b7c2e9df933f6828dd9739b=
fba84
Author:        Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
AuthorDate:    Mon, 10 Mar 2025 14:21:58 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 10 Mar 2025 20:02:14 +01:00

<linux/cleanup.h>: Allow the passing of both iomem and non-iomem pointers to =
no_free_ptr()

Calling no_free_ptr() for an __iomem pointer results in Sparse
complaining about the types:

  warning: incorrect type in argument 1 (different address spaces)
     expected void const volatile *val
     got void [noderef] __iomem *__val

[ The example is from drivers/platform/x86/intel/pmc/core_ssram.c:283 ]

The problem is caused by the signature of __must_check_fn() added in:

  85be6d842447 ("cleanup: Make no_free_ptr() __must_check")

... to enforce that the return value is always used.

Use __force to allow both iomem and non-iomem pointers to be given for
no_free_ptr().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250310122158.20966-1-ilpo.jarvinen@linux.in=
tel.com
Closes: https://lore.kernel.org/oe-kbuild-all/202403050547.qnZtuNlN-lkp@intel=
.com/
---
 include/linux/cleanup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index ec00e3f..ee2614a 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -212,7 +212,7 @@ const volatile void * __must_check_fn(const volatile void=
 *val)
 { return val; }
=20
 #define no_free_ptr(p) \
-	((typeof(p)) __must_check_fn(__get_and_null(p, NULL)))
+	((typeof(p)) __must_check_fn((__force const volatile void *)__get_and_null(=
p, NULL)))
=20
 #define return_ptr(p)	return no_free_ptr(p)
=20

