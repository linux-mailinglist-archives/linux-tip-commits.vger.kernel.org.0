Return-Path: <linux-tip-commits+bounces-3168-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6A9A00B32
	for <lists+linux-tip-commits@lfdr.de>; Fri,  3 Jan 2025 16:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262891884626
	for <lists+linux-tip-commits@lfdr.de>; Fri,  3 Jan 2025 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3E51CCB4B;
	Fri,  3 Jan 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YwahyVhd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AU/uOx+N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC06442C;
	Fri,  3 Jan 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735917157; cv=none; b=tzxM5jdpGTBlzUDv8Kyte41S2VD7UCRKpAG/gFKyqO916B/nu8uqm/s3MXwcPRR9AYUCa+lpW0A6GlxqWLzcAP4ib6BI3ZCaFTds4IO+wakmUDPVRe5K6awAyes3B5LgCqUUQVp0bBM8vitFGHoBfHzhETMzIB4pPt9K61xA7bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735917157; c=relaxed/simple;
	bh=rrKAdXaOlmtceRfG593QlT78xNrdu85suL4+URVsyZo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wfn7iq8yImkmnkIH9tMYtWJRfZC4OgKsDobSgGH00D3ul7Tla76v8g1qha2MVzaFTTdqw+G8/HZslrBbwHA3UeRv7/nwVV50S6MLLBwqq+YulM6iG3LlcdvHasIbneEoMSt8T6PS2Q7NOjLqaoED4/LY14+Ph4esPKkwqMNeXnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YwahyVhd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AU/uOx+N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 03 Jan 2025 15:12:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735917148;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RfqFizfMXBWJyh3mqCvvKMsnEipy1mWKZHNnCKRGDhI=;
	b=YwahyVhdaIMpEzTe68uxZlzJMavCD8gPjQly2ZCftfAunyyfVWzOJV0ignmg/lr4uQk6w4
	3/JWZ8pFp/e1IHvnEj+PyYiug9g6kf0sOasNGhyaHzy+JfYEjrInQroNgS3dB2C7ZG5C/Y
	TslNn20Nm8MkkDPoQzbMM3mEw4wLXxTPkBedi6G/2RxN5aXxtAdYwrbw802WAKyNLRHGsT
	0ElQ9fA+oIpa/uB00KbLAfhI5z/+bzvj5akc4OAAaZlUEYeff8lQP5/BITPeaDIpykw3UA
	df9K0DTL2E2WtVM74t8AEacBo8+JU/n5tHL2Uk9TF3OVRJRQOdzKlB+Q8vfBXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735917148;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RfqFizfMXBWJyh3mqCvvKMsnEipy1mWKZHNnCKRGDhI=;
	b=AU/uOx+N28SZAegkbpwKzHHySasz/zgePW/tG6fPp/O7IY3v5AiDo2374sTHiRAUCEX4rA
	UoYpucDVUawxo/Bw==
From: "tip-bot2 for Alan Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/ioapic: Remove a stray tab in the IO-APIC type string
Cc: Alan Song <syfmark114@163.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241230065706.16789-1-syfmark114@163.com>
References: <20241230065706.16789-1-syfmark114@163.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173591714390.399.11329319430157889408.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     0094014be0cd75273ef7f2934c17fb8cffd4db6e
Gitweb:        https://git.kernel.org/tip/0094014be0cd75273ef7f2934c17fb8cffd4db6e
Author:        Alan Song <syfmark114@163.com>
AuthorDate:    Mon, 30 Dec 2024 14:57:06 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 03 Jan 2025 16:02:29 +01:00

x86/ioapic: Remove a stray tab in the IO-APIC type string

The type "physic	al" should be "physical".

  [ bp: Massage commit message. ]

Fixes: 54cd3795b471 ("x86/ioapic: Cleanup guarded debug printk()s")
Signed-off-by: Alan Song <syfmark114@163.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241230065706.16789-1-syfmark114@163.com
---
 arch/x86/kernel/apic/io_apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 1029ea4..0306246 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1165,7 +1165,7 @@ static void io_apic_print_entries(unsigned int apic, unsigned int nr_entries)
 				 (entry.ir_index_15 << 15) | entry.ir_index_0_14, entry.ir_zero);
 		} else {
 			apic_dbg("%s, %s, D(%02X%02X), M(%1d)\n", buf,
-				 entry.dest_mode_logical ? "logical " : "physic	al",
+				 entry.dest_mode_logical ? "logical " : "physical",
 				 entry.virt_destid_8_14, entry.destid_0_7, entry.delivery_mode);
 		}
 	}

