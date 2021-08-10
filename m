Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707003E5640
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 11:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbhHJJIH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 05:08:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41876 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbhHJJIF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 05:08:05 -0400
Date:   Tue, 10 Aug 2021 09:07:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628586461;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gxqa8nbwnFRiQ1PT8I8LRkSFEgM/fHFqNWU4QKbVjjY=;
        b=zHT6fNPJCl3R8WONQJIpVHPcnHEFd47OrODRXH9nigumSv0D/UhcQIbEWjXavP+fEy5gAg
        ZNbRBf9oSJdmYqDU1uxbKVXYIDx2TXs/NlIATLz1WFFDpblzupDnHOuceHD42LktfKaJv4
        DEC+q8+SNQuyQDnppShEoECLdZxe7qGO83N7wCYnW+RMu8pIUM9jF40PMAF73X+dBS+hmq
        SUMTmvaOTc79cRzxSdHGnJScHWUr1orIGdOswY8wB1OwhnX19/wa5nTBEJMJUEtn/vhEAn
        VOe7o+oyuXGjkty5x/sRWGHVW9CzH78ViEofFF3kkn6rVrfhF1P3vbTXuH8g7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628586461;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gxqa8nbwnFRiQ1PT8I8LRkSFEgM/fHFqNWU4QKbVjjY=;
        b=g5BIq8IwEBcenB0SpUWzvU8gQ1NaUT0+UL4ujz7eeGexwTEO6UxcW47kbhC8lq0SvUXCum
        +xo55yiaupfas6Ag==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Simplify msi_verify_entries()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210729222542.992849326@linutronix.de>
References: <20210729222542.992849326@linutronix.de>
MIME-Version: 1.0
Message-ID: <162858646108.395.9412874888117593842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a6e8b946508cda3c3bf0f9b0e133d293dc9754f6
Gitweb:        https://git.kernel.org/tip/a6e8b946508cda3c3bf0f9b0e133d293dc9754f6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Jul 2021 23:51:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 11:03:29 +02:00

PCI/MSI: Simplify msi_verify_entries()

No point in looping over all entries when 64bit addressing mode is enabled
for nothing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20210729222542.992849326@linutronix.de

---
 drivers/pci/msi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 95e6ce4..b59957c 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -613,8 +613,11 @@ static int msi_verify_entries(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
 
+	if (!dev->no_64bit_msi)
+		return 0;
+
 	for_each_pci_msi_entry(entry, dev) {
-		if (entry->msg.address_hi && dev->no_64bit_msi) {
+		if (entry->msg.address_hi) {
 			pci_err(dev, "arch assigned 64-bit MSI address %#x%08x but device only supports 32 bits\n",
 				entry->msg.address_hi, entry->msg.address_lo);
 			return -EIO;
