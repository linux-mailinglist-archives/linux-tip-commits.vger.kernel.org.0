Return-Path: <linux-tip-commits+bounces-8371-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD6yA4n1qWmcIgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8371-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 22:28:41 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6757B218814
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 22:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51535300A76A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Mar 2026 21:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3288635DA5C;
	Thu,  5 Mar 2026 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f3Wxpzr5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rOC+IWwG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3181350A39;
	Thu,  5 Mar 2026 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772746081; cv=none; b=Z3g00fTRnvFA4Za2AssL2EQiywiQibSx5xtI/8YTWbeq5gbQu7bwx40/OffRtazGVBPXNgbawpfJ879Qcihu0VU/2aqteuwlZCHwWKx8FcGBD6fX5hC3mB2unx3+v99G6z2c7bFOz961s1npLfFcmYxs1QS6PcrVl7HTBQTitQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772746081; c=relaxed/simple;
	bh=X3wbBPrze8+dv4HRCmJCl9mWJy00PQfJIl5zVkPaLUg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=px0bIPNY60pAEui3W9GqGwJzF/eTJqhcC33b4ZnmBrJpRoif4aCIneR6ipv8kLeD/qkrT02k0GvmlCQZseR0Md1ZcQU7B/0ZP+8izXQHvpcAYczKSSK6O1YParIrt5tDtc7EPk7OMiaQIimT6iidTxQN09L6+xc+TPNvOzL8+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f3Wxpzr5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rOC+IWwG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Mar 2026 21:27:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772746078;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mURUiFOJVbYg6RJmqkEzUBsG2u7c1L7hqIwgr7vsM/E=;
	b=f3Wxpzr5Waw33VKbCsLiW9vmVdaFFWNpCfp9aE3NlmF4+tTBocIrDg+ZaycMm1VJpnZWH6
	i+WKCn3xGqpmjX40hELUry1/I0JnVLAF2iRe/jPcCA4LW5rKy2ZNaEyOzkjOG4VzFmAbum
	KQ6jMK3oYXeBIM7ITy+OWF+X/gLMEioHvW3C8PDVFmkmrpmxqhdo4XW2kLOU766RjhWREe
	62Xw1S//R3z6g8PlrtfM0o3mj2vi0u+3HOwcxpGEVkMh9froJLbqIGonJJ/HMOLqtNBm2L
	RzH+LDYfZVWwrIdZH953E0tOiKTdssTq2lcRI0nEgdVN40UzvSFdGF1V/3dDBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772746078;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mURUiFOJVbYg6RJmqkEzUBsG2u7c1L7hqIwgr7vsM/E=;
	b=rOC+IWwGURHGGLEOE9id1DTOJF1tjx+snPokigeV0pM/4xOE7LD+23DgdheFiWO0104VHK
	W4REVxyIDo6xY9Cg==
From: "tip-bot2 for Kuppuswamy Sathyanarayanan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] virt: tdx-guest: Return error for GetQuote failures
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Kai Huang <kai.huang@intel.com>,
 Mikko Ylinen <mikko.ylinen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20260116230315.4023504-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References:
 <20260116230315.4023504-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177274607715.1647592.4525821410946803418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6757B218814
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8371-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:url,intel.com:email,vger.kernel.org:replyto,msgid.link:url]
X-Rspamd-Action: no action

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     0f409eaea53e49932cf92a761de66345c9a4b4be
Gitweb:        https://git.kernel.org/tip/0f409eaea53e49932cf92a761de66345c9a=
4b4be
Author:        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.i=
ntel.com>
AuthorDate:    Fri, 16 Jan 2026 15:03:15 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 05 Mar 2026 13:23:58 -08:00

virt: tdx-guest: Return error for GetQuote failures

Currently, the GetQuote request handler returns explicit errors for
hypercall-level failures and timeouts, but it ignores some VMM
failures (e.g., GET_QUOTE_SERVICE_UNAVAILABLE), for which it returns
success with a zero-length Quote. This makes error handling in
userspace more complex.

The VMM reports failures via the status field in the shared GPA header,
which is inaccessible to userspace because only the Quote payload is
exposed to userspace. Parse the status field in the kernel and return
an error for Quote failures.

This preserves existing ABI behavior as userspace already treats a
zero-length Quote as a failure.

Refer to GHCI specification [1], section "TDG.VP.VMCALL <GetQuote>",
Table 3-10 and Table 3-11 for details on the GPA header and
GetQuote status codes.

Closes: https://lore.kernel.org/linux-coco/6bdf569c-684a-4459-af7c-4430691804=
eb@linux.intel.com/T/#u
Closes: https://github.com/confidential-containers/guest-components/issues/823
Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM=
_REPORTS")
Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.i=
ntel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Tested-by: Mikko Ylinen <mikko.ylinen@linux.intel.com>
Link: https://cdrdv2.intel.com/v1/dl/getContent/858626 # [1]
Link: https://patch.msgid.link/20260116230315.4023504-1-sathyanarayanan.kuppu=
swamy@linux.intel.com
---
 drivers/virt/coco/tdx-guest/tdx-guest.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-=
guest/tdx-guest.c
index 4252b14..23ef399 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -306,6 +306,11 @@ static int tdx_report_new_locked(struct tsm_report *repo=
rt, void *data)
 		return ret;
 	}
=20
+	if (quote_buf->status !=3D GET_QUOTE_SUCCESS) {
+		pr_debug("GetQuote request failed, status:%llx\n", quote_buf->status);
+		return -EIO;
+	}
+
 	buf =3D kvmemdup(quote_buf->data, quote_buf->out_len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;

