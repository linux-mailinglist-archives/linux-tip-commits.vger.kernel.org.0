Return-Path: <linux-tip-commits+bounces-7644-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B847CBA7F7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Dec 2025 11:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A78393012961
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Dec 2025 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD082F5322;
	Sat, 13 Dec 2025 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eCq/QrKp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0fmeIrLn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A042F49FC;
	Sat, 13 Dec 2025 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765620442; cv=none; b=Jqru5Kcb7DEJ7eQU3xDP130CCzcPk6KdF4888ZQHAyWI7Z5fOfRWqK3fKo/oF0Rx0wrMpT+gAnNasQbqimn92w8iTkIe3VZAFtmc3CiMk/J6zkTjMqN6UrMPBH0ArsiDzbnE1jiSXrZGFajcoBfTbevWe0K154Pbcjs6gJyOI/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765620442; c=relaxed/simple;
	bh=dUfko8XUSrXudJQO+AAgBJjgKfukWpxqbfsUmYfimjc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZeNbC1VPHb1JLAtHUBi7rxh6YkNDz9xvac44CG42gqIB4yPsWzCRwGKSstU++V9X4tLQjyyaDDdAqwBy1EEgQpziSt6GQCucKKMIxYlboFsF9XhXbktRjtyghl+O81T+2NX7wxrrHHj7vVmU2KyHks2303B+XxMXzrL7cbzAKq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eCq/QrKp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0fmeIrLn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Dec 2025 10:07:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765620438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wsh1ikITkajrK+kkIASoVBhV1yG3XtFKktzmOO65syQ=;
	b=eCq/QrKp6v0XqCo3dwOBYzkir8JG0VETpnTnFG/E1htzNsl4Su+VfBJ2v9wNtizO2TJbZ5
	vVoEwb9uxpXcXrxyL6gxLT9W4OqELiYPHtELahCFAWvSBzWaG/RFNQDABdAtDB0Fji/dpF
	oT9f5r7lT2xl1T8BtTBzrticNvR/P6rH+TPPlduvHqKA9em1GFPLpS2dJQWgmikH8rHaLa
	V1DksdKdoB1UCZaFZriIvdEcmz5k7leVYsfpVeuCDgbhyhYwUvQWe0FtWYA5L94WKEltbl
	L5i2DeP5x7a79LUlIliSqkXjmwK/XZyVIRFEtqTKsScsSo/PtU0bdYeGWtZ0iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765620438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wsh1ikITkajrK+kkIASoVBhV1yG3XtFKktzmOO65syQ=;
	b=0fmeIrLnvit+wjNEuQBC+DRSFiqOV2+M5iAElu1P7H5Wo2QzvfGk1AEgkxV5MwJWMs2jlM
	xXYDSo84K4T096Dg==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sgx: Remove unmatched quote in
 __sgx_encl_extend function comment
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 Kai Huang <kai.huang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251210125628.544916-1-thorsten.blum@linux.dev>
References: <20251210125628.544916-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176562043757.498.4297505161089176946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     043507144ae13d3b882d40495d101bb4c4990d98
Gitweb:        https://git.kernel.org/tip/043507144ae13d3b882d40495d101bb4c49=
90d98
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Wed, 10 Dec 2025 13:56:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 13 Dec 2025 11:01:16 +01:00

x86/sgx: Remove unmatched quote in __sgx_encl_extend function comment

There is no opening quote. Remove the unmatched closing quote.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://patch.msgid.link/20251210125628.544916-1-thorsten.blum@linux.dev
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 66f1efa..9322a92 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -242,7 +242,7 @@ static int __sgx_encl_add_page(struct sgx_encl *encl,
 /*
  * If the caller requires measurement of the page as a proof for the content,
  * use EEXTEND to add a measurement for 256 bytes of the page. Repeat this
- * operation until the entire page is measured."
+ * operation until the entire page is measured.
  */
 static int __sgx_encl_extend(struct sgx_encl *encl,
 			     struct sgx_epc_page *epc_page)

