Return-Path: <linux-tip-commits+bounces-6255-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743E5B282E2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Aug 2025 17:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3CD6038C7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Aug 2025 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FBD2FABFD;
	Fri, 15 Aug 2025 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v60iJg4+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V7SOFShs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B12C3273;
	Fri, 15 Aug 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271345; cv=none; b=rXeFE+/fbqWpRhJIKEtLqHIW4uChqSWWzcechy/JVnvGA2Lubgaj3GhBip8sqNVZXczpK7+P9cz2hxdkyX/6jJqdCYt4Oe6IAXL7X9ctOAkcmz/+XQUICW+NNvdRT4W79y7ljAqyAroF+O/TuIqxMPXN+2hMjb+3rvTI5Sw+Bn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271345; c=relaxed/simple;
	bh=aR5Zb8EECkOqoj4GRCQvi76EvfhKe4Uhgdhjp7foq/A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QI1MkIfvzub8XqqK+QYDaFeFKA3Ia0IiZbp2ZUi3U08859TDtoarZDjqKHud9NA6/78nlOQPSVjB/9XPP3GSN60WA+H03O6sKpayNQ/Y6E2WRQxkcnaS/htHPQ51G3js/IjhMywKt+wE6KY82vy3I4BCFHtGAN9tPXoXT8p8Bdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v60iJg4+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V7SOFShs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Aug 2025 15:22:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755271340;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYKlEfZ3GAds9k72HOauQeEeAg+41YYXhpxu8Ok/Y6E=;
	b=v60iJg4+bxwHQnLjlPfpMpCPSOb7mvyMCJ+oy8U+0c66UjLx4r2SwYrRMwzCCra6vZVtIC
	5lfEPzPnjKfliebYjc/zkokTGTuHC+3qyE0h5r0wdCVDwZS5TGMO1BFQFQKV3+gSm7wLw7
	Tci2zvjK7aznFgmbp42M2RC9xoS2vjuoKjbUYZxGUqFMHYjlWbMHOmSh85HcYosSowQi6a
	tu0DtO5eDeF1cqEgyn7kolIAlxR/SiUEIlUeaNt0DijaHSO5toHUgmv3IpURhnVFQ9HA+8
	o88i6sPW+6/ebhx1NY5fWwutDIwg5dwSOb5gaCVDltSnDqilabr5YzK47WwHyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755271340;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hYKlEfZ3GAds9k72HOauQeEeAg+41YYXhpxu8Ok/Y6E=;
	b=V7SOFShs41V3rAve0Ontip9YHyAAc0lguhQ6DOEyPo6BKmYc5Bor94xYDuOeWzESz8g8l5
	68pgLzYkqRSWG7BQ==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] virt: sev-guest: Satisfy linear mapping requirement
 in get_derived_key()
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C9b764ca9fc79199a091aac684c4926e2080ca7a8=2E1752698?=
 =?utf-8?q?495=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C9b764ca9fc79199a091aac684c4926e2080ca7a8=2E17526984?=
 =?utf-8?q?95=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175527133949.1420.3569330113861984110.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c08ba63078dd6046c279df37795cb77e784e1ec9
Gitweb:        https://git.kernel.org/tip/c08ba63078dd6046c279df37795cb77e784=
e1ec9
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 16 Jul 2025 15:41:35 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 15 Aug 2025 17:05:39 +02:00

virt: sev-guest: Satisfy linear mapping requirement in get_derived_key()

Commit

  7ffeb2fc2670 ("x86/sev: Document requirement for linear mapping of guest re=
quest buffers")

added a check that requires the guest request buffers to be in the linear
mapping. The get_derived_key() function was passing a buffer that was
allocated on the stack, resulting in the call to snp_send_guest_request()
returning an error.

Update the get_derived_key() function to use an allocated buffer instead
of a stack buffer.

Fixes: 7ffeb2fc2670 ("x86/sev: Document requirement for linear mapping of gue=
st request buffers")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/9b764ca9fc79199a091aac684c4926e2080ca7a8.175269=
8495.git.thomas.lendacky@amd.com
---
 drivers/virt/coco/sev-guest/sev-guest.c | 27 ++++++++++--------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-=
guest/sev-guest.c
index d2b3ae7..b01ec99 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -116,13 +116,11 @@ e_free:
=20
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_r=
equest_ioctl *arg)
 {
+	struct snp_derived_key_resp *derived_key_resp __free(kfree) =3D NULL;
 	struct snp_derived_key_req *derived_key_req __free(kfree) =3D NULL;
-	struct snp_derived_key_resp derived_key_resp =3D {0};
 	struct snp_msg_desc *mdesc =3D snp_dev->msg_desc;
 	struct snp_guest_req req =3D {};
 	int rc, resp_len;
-	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
-	u8 buf[64 + 16];
=20
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
@@ -132,8 +130,9 @@ static int get_derived_key(struct snp_guest_dev *snp_dev,=
 struct snp_guest_reque
 	 * response payload. Make sure that it has enough space to cover the
 	 * authtag.
 	 */
-	resp_len =3D sizeof(derived_key_resp.data) + mdesc->ctx->authsize;
-	if (sizeof(buf) < resp_len)
+	resp_len =3D sizeof(derived_key_resp->data) + mdesc->ctx->authsize;
+	derived_key_resp =3D kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
+	if (!derived_key_resp)
 		return -ENOMEM;
=20
 	derived_key_req =3D kzalloc(sizeof(*derived_key_req), GFP_KERNEL_ACCOUNT);
@@ -149,23 +148,21 @@ static int get_derived_key(struct snp_guest_dev *snp_de=
v, struct snp_guest_reque
 	req.vmpck_id =3D mdesc->vmpck_id;
 	req.req_buf =3D derived_key_req;
 	req.req_sz =3D sizeof(*derived_key_req);
-	req.resp_buf =3D buf;
+	req.resp_buf =3D derived_key_resp;
 	req.resp_sz =3D resp_len;
 	req.exit_code =3D SVM_VMGEXIT_GUEST_REQUEST;
=20
 	rc =3D snp_send_guest_request(mdesc, &req);
 	arg->exitinfo2 =3D req.exitinfo2;
-	if (rc)
-		return rc;
-
-	memcpy(derived_key_resp.data, buf, sizeof(derived_key_resp.data));
-	if (copy_to_user((void __user *)arg->resp_data, &derived_key_resp,
-			 sizeof(derived_key_resp)))
-		rc =3D -EFAULT;
+	if (!rc) {
+		if (copy_to_user((void __user *)arg->resp_data, derived_key_resp,
+				 sizeof(derived_key_resp->data)))
+			rc =3D -EFAULT;
+	}
=20
 	/* The response buffer contains the sensitive data, explicitly clear it. */
-	memzero_explicit(buf, sizeof(buf));
-	memzero_explicit(&derived_key_resp, sizeof(derived_key_resp));
+	memzero_explicit(derived_key_resp, sizeof(*derived_key_resp));
+
 	return rc;
 }
=20

