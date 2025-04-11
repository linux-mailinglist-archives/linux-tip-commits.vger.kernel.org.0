Return-Path: <linux-tip-commits+bounces-4890-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52499A8594B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C1B3BD95E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0891221275;
	Fri, 11 Apr 2025 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UZC21FLZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wXSHxwGu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E096C278E68;
	Fri, 11 Apr 2025 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744366546; cv=none; b=cdEh+p6n8+lwoWpTlRAzsqM0A5aMKHwqT/rjCqVLbZ15doWofISAdJw+xAWjp/hFS7ZI3NHknlhbekLJfhwvbm+5y9aWFAti9bU29wwkigHstR8fGnfUaIvmDl3UljJeUgYXb+EZ0HX7UNzP0IkTbWfDIbnVM8keMQ3GCj9FAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744366546; c=relaxed/simple;
	bh=VfWfsCy2jSyheOfT9L1IDiw3j3bhdqaLXB0s6JA7GCI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CUFK1sHdKGiuEwzu9xcJdjAzb8dycMYF6j40x1V+oDXA9LUr2IPTxpNhOZt/KUHpzP4MizA2SCQn0ZAw4GJXLjtXzeJpIMP8LoRFU7899LPZDu76g5AB+s5y2A3CiC0cb11jSJBAbKPSXFnnTvQIuEYNs5cGqyUjVqORnfo+UII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UZC21FLZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wXSHxwGu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:15:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744366543;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h72aED5xghVW9dVLr0BWESKFgrmGfSo5qd1eS/uSqKg=;
	b=UZC21FLZGUnWyWAy9ovqYOO8FNGRuTfWqCEERvqm5IIfUaCKku5wRaXauySbtlibKeM8SE
	CTVhoS+Bzs37AGAeKRhBh5u9tSLBB3fKzK8AmD9dyzmaNPXR3uzw62+8Io+2ACCSbWZ0++
	PftuofCSCj5OyjG2nCrdYDiGm0RaqsI4X3bjAndcet00Ssfdp57VlptFHuEIijb0V7XwBS
	VWoIV/NJS9degxsksJMjgBk3l0llOLov0DIEwnQ+zECVzQs2TCHBoIaNvKpSgDOo/QSKrF
	qCRjgAjkqtl10XeliAZDNj/xiAYtVAVyXcTjKwdUncZfSHgX8TJEaPhuq3AN3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744366543;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h72aED5xghVW9dVLr0BWESKFgrmGfSo5qd1eS/uSqKg=;
	b=wXSHxwGuMqO2jm0uBaNW9kPqq5r5m/awsCPV90g71+KXwX8d2XAWX7NIHqac2o5mN0YpIe
	Zi2rCEso+y6VmxCQ==
From: "tip-bot2 for Stefano Garzarella" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] svsm: Add header with SVSM_VTPM_CMD helpers
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250403100943.120738-3-sgarzare@redhat.com>
References: <20250403100943.120738-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436654254.31282.1735564500644332385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     b2849b0723668ae3e0739b2c9c066eafe8bc0961
Gitweb:        https://git.kernel.org/tip/b2849b0723668ae3e0739b2c9c066eafe8b=
c0961
Author:        Stefano Garzarella <sgarzare@redhat.com>
AuthorDate:    Thu, 03 Apr 2025 12:09:40 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Apr 2025 16:20:06 +02:00

svsm: Add header with SVSM_VTPM_CMD helpers

Add helpers for the SVSM_VTPM_CMD calls used by the vTPM protocol defined by
the AMD SVSM spec [1].

The vTPM protocol follows the Official TPM 2.0 Reference Implementation
(originally by Microsoft, now part of the TCG) simulator protocol.

  [1] "Secure VM Service Module for SEV-SNP Guests"
      Publication # 58019 Revision: 1.00

Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20250403100943.120738-3-sgarzare@redhat.com
---
 include/linux/tpm_svsm.h | 149 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+)
 create mode 100644 include/linux/tpm_svsm.h

diff --git a/include/linux/tpm_svsm.h b/include/linux/tpm_svsm.h
new file mode 100644
index 0000000..38e341f
--- /dev/null
+++ b/include/linux/tpm_svsm.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 James.Bottomley@HansenPartnership.com
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ *
+ * Helpers for the SVSM_VTPM_CMD calls used by the vTPM protocol defined by =
the
+ * AMD SVSM spec [1].
+ *
+ * The vTPM protocol follows the Official TPM 2.0 Reference Implementation
+ * (originally by Microsoft, now part of the TCG) simulator protocol.
+ *
+ * [1] "Secure VM Service Module for SEV-SNP Guests"
+ *     Publication # 58019 Revision: 1.00
+ */
+#ifndef _TPM_SVSM_H_
+#define _TPM_SVSM_H_
+
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#define SVSM_VTPM_MAX_BUFFER		4096 /* max req/resp buffer size */
+
+/**
+ * struct svsm_vtpm_request - Generic request for single word command
+ * @cmd:	The command to send
+ *
+ * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
+ * Table 15: vTPM Common Request/Response Structure
+ *     Byte      Size   =C2=A0=C2=A0 =C2=A0In/Out=C2=A0=C2=A0=C2=A0=C2=A0Des=
cription
+ *     Offset=C2=A0=C2=A0=C2=A0=C2=A0(Bytes)
+ *     0x000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0In=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
Platform command
+=C2=A0*=C2=A0=C2=A0=C2=A0  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Platform command response size
+ */
+struct svsm_vtpm_request {
+	u32 cmd;
+};
+
+/**
+ * struct svsm_vtpm_response - Generic response
+ * @size:	The response size (zero if nothing follows)
+ *
+ * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
+ * Table 15: vTPM Common Request/Response Structure
+ *     Byte      Size   =C2=A0=C2=A0 =C2=A0In/Out=C2=A0=C2=A0=C2=A0=C2=A0Des=
cription
+ *     Offset=C2=A0=C2=A0=C2=A0=C2=A0(Bytes)
+ *     0x000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0In=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
Platform command
+=C2=A0*=C2=A0=C2=A0=C2=A0  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0Out=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Platform command response size
+ *
+ * Note: most TCG Simulator commands simply return zero here with no indicat=
ion
+ * of success or failure.
+ */
+struct svsm_vtpm_response {
+	u32 size;
+};
+
+/**
+ * struct svsm_vtpm_cmd_request - Structure for a TPM_SEND_COMMAND request
+ * @cmd:	The command to send (must be TPM_SEND_COMMAND)
+ * @locality:	The locality
+ * @buf_size:	The size of the input buffer following
+ * @buf:	A buffer of size buf_size
+ *
+ * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
+ * Table 16: TPM_SEND_COMMAND Request Structure
+ *     Byte      Size       Meaning
+ *     Offset=C2=A0=C2=A0=C2=A0=C2=A0(Bytes)
+ *     0x000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0Platform command (8)
+ *     0x004=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0Locality (must-be-0)
+ *     0x005=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0TPM Command size (in bytes)
+ *     0x009=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Variable=C2=A0=C2=A0=C2=A0TPM Comm=
and
+ *
+ * Note: the TCG Simulator expects @buf_size to be equal to the size of the
+ * specific TPM command, otherwise an TPM_RC_COMMAND_SIZE error is returned.
+ */
+struct svsm_vtpm_cmd_request {
+	u32 cmd;
+	u8 locality;
+	u32 buf_size;
+	u8 buf[];
+} __packed;
+
+/**
+ * struct svsm_vtpm_cmd_response - Structure for a TPM_SEND_COMMAND response
+ * @buf_size:	The size of the output buffer following
+ * @buf:	A buffer of size buf_size
+ *
+ * Defined by AMD SVSM spec [1] in section "8.2 SVSM_VTPM_CMD Call" -
+ * Table 17: TPM_SEND_COMMAND Response Structure
+ *     Byte      Size       Meaning
+ *     Offset=C2=A0=C2=A0=C2=A0=C2=A0(Bytes)
+ *     0x000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A04=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0Response size (in bytes)
+ *     0x004=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Variable=C2=A0=C2=A0=C2=A0Response
+ */
+struct svsm_vtpm_cmd_response {
+	u32 buf_size;
+	u8 buf[];
+};
+
+/**
+ * svsm_vtpm_cmd_request_fill() - Fill a TPM_SEND_COMMAND request to be sent=
 to SVSM
+ * @req: The struct svsm_vtpm_cmd_request to fill
+ * @locality: The locality
+ * @buf: The buffer from where to copy the payload of the command
+ * @len: The size of the buffer
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static inline int
+svsm_vtpm_cmd_request_fill(struct svsm_vtpm_cmd_request *req, u8 locality,
+			   const u8 *buf, size_t len)
+{
+	if (len > SVSM_VTPM_MAX_BUFFER - sizeof(*req))
+		return -EINVAL;
+
+	req->cmd =3D 8; /* TPM_SEND_COMMAND */
+	req->locality =3D locality;
+	req->buf_size =3D len;
+
+	memcpy(req->buf, buf, len);
+
+	return 0;
+}
+
+/**
+ * svsm_vtpm_cmd_response_parse() - Parse a TPM_SEND_COMMAND response receiv=
ed from SVSM
+ * @resp: The struct svsm_vtpm_cmd_response to parse
+ * @buf: The buffer where to copy the response
+ * @len: The size of the buffer
+ *
+ * Return: buffer size filled with the response on success, negative error
+ * code on failure.
+ */
+static inline int
+svsm_vtpm_cmd_response_parse(const struct svsm_vtpm_cmd_response *resp, u8 *=
buf,
+			     size_t len)
+{
+	if (len < resp->buf_size)
+		return -E2BIG;
+
+	if (resp->buf_size > SVSM_VTPM_MAX_BUFFER - sizeof(*resp))
+		return -EINVAL;  // Invalid response from the platform TPM
+
+	memcpy(buf, resp->buf, resp->buf_size);
+
+	return resp->buf_size;
+}
+
+#endif /* _TPM_SVSM_H_ */

