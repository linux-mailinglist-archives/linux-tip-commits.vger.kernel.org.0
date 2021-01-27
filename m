Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A7E306448
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Jan 2021 20:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344520AbhA0Tku (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Jan 2021 14:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhA0Tbz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Jan 2021 14:31:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7FFC061574;
        Wed, 27 Jan 2021 11:31:14 -0800 (PST)
Date:   Wed, 27 Jan 2021 19:31:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611775871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Sr79TrzJawLjE8wrxofMFwXLES6Vm10mLFZx+zKvpGg=;
        b=joLmRha8gn3MsniPh/hJJ9bNgYzOuoSt3Wxy4bFXh+QvvkfDUULnL4UIOCrylei/pV9f0Y
        +/xwinoIvITCu5q1itb7FeIzC3tIdSm0N4Xt6/7CbmUqrJ5udIRiL3YXFVNea8bq3gqKUF
        4lOn62T7l4qccG8VbLKFxebWNFe/FgnYZ+kFJQkBXt1EFKVsr1MGcFmVHvoWXlZQX+nM3k
        gJV79pgQZbZkG5qtbCP8wWcBG9Yk2evIRA4Yke0J56jfq4MSQET7TafKnmAQUxNmUWOQND
        kp6MD2SKwjdMKdWNsJsyq9cs/N77QrS5/Sv2TIqwDrlokDxqYF1WE5Ev3OlgpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611775871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Sr79TrzJawLjE8wrxofMFwXLES6Vm10mLFZx+zKvpGg=;
        b=5xAFvjuBa5CG26FHpH10T75Fz7yZsPJKTW3PiWFxDfqYSFDxVt2BB3gOCB4Vz1HV8/5w9n
        x/3fLbEAMayCVaBA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/libstub: fix prototype of
 efi_tcg2_protocol::get_event_log()
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161177587087.23325.9797758288609195166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     cdec91c034a2c99331b62a5f417bf7527fa6d490
Gitweb:        https://git.kernel.org/tip/cdec91c034a2c99331b62a5f417bf7527fa6d490
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 02 Nov 2020 10:04:39 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 19 Jan 2021 17:57:15 +01:00

efi/libstub: fix prototype of efi_tcg2_protocol::get_event_log()

efi_tcg2_protocol::get_event_log() takes a protocol pointer as the
first argument, not a EFI handle.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index b50a6c6..2b7438b 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -672,7 +672,7 @@ typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
 union efi_tcg2_protocol {
 	struct {
 		void *get_capability;
-		efi_status_t (__efiapi *get_event_log)(efi_handle_t,
+		efi_status_t (__efiapi *get_event_log)(efi_tcg2_protocol_t *,
 						       efi_tcg2_event_log_format,
 						       efi_physical_addr_t *,
 						       efi_physical_addr_t *,
