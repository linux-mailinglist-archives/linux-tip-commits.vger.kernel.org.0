Return-Path: <linux-tip-commits+bounces-7633-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCEBCB85FB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 10:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C889830115E1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 09:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C5A30F7E8;
	Fri, 12 Dec 2025 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z47hSc2G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Ca6X2Xh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66B986352;
	Fri, 12 Dec 2025 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530297; cv=none; b=okTkG4p05V9tSttptcIcpOi2cPd2Hy6hgiuNIO6A27AroMrrg23j2K2BSFBmEelRCsK+FJsx1OKEdpiRsqcBh2NhXyUUxBOHi9zr3iEVX2SUOoLGzpOA2MeRJRVvj3hYTVRCU7AOZ6IOPufwkSpgOs6jchNYVuqdDiIrupglhOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530297; c=relaxed/simple;
	bh=lOcqwY/HpnNT53NRzSG9scS8V8+RlDLl/8wmU38Lgtk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e84a/8lCVPd6JV0vKicP/3hTQUc/b6WQUY7ydvDCCcxs2q5uQQNgJEeQr5AIzgZZbnu+781d9JFrlmlJgI36D+HJy62ETbkFEnzbv4QbsiKMr0yuORcer4P+fPllnm841J76KBA23tR/iQzxSt40I+xkRStna3v6AkN7l4YHBqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z47hSc2G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Ca6X2Xh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Dec 2025 09:04:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765530294;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2rzjdSR0TH+6TLpmCxx9MaaA2O2TLKA2CKCb8zGcMI4=;
	b=z47hSc2G58ZhmzHpNre9WOr3rOS4wu1WUBM/zZBNi2H9qKmNQZve2uyHPhWi6MsYWGAtbU
	Oh16q9KVHOMyY4XYqDK+1jbvSX6Y3wGdaukof2Rz5iryRNVOt4ZaJMte7DpYg7VP91QCo3
	/amqERudwvkYhIWJDJ55T0KTlWcB0d9+9tzgHeAhE+V2RxmP9xa0B4/anBwgiKEQt3+tnF
	JunMbJWLjLoJ5rpm7L4Ty2rvDuQYTVnjflhPgy8wvGUisvPXZbGxPpzZaONlVupQBPuTpQ
	vV3hKt7lKqogTInIKK2Z+haxPMgsptuC+bz+YkXijYa5wJuDy165gyt8F1278w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765530294;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2rzjdSR0TH+6TLpmCxx9MaaA2O2TLKA2CKCb8zGcMI4=;
	b=3Ca6X2Xhv3AsedVyFIESjoXNQcsKGVaS69iC0DCKUAsk6JtEI+A2zSPP8rqg6fpcQ/dt/z
	zhNEpBj1qIzCYZCg==
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
Message-ID: <176553029303.498.17412391711385048298.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d63bc9210ba0329c4e714cd231d7138c90674629
Gitweb:        https://git.kernel.org/tip/d63bc9210ba0329c4e714cd231d7138c906=
74629
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Wed, 10 Dec 2025 13:56:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Dec 2025 09:50:31 +01:00

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

