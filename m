Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0567A29D4A7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Oct 2020 22:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgJ1Vxq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Oct 2020 17:53:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:43394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgJ1Vxm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Oct 2020 17:53:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12B82ACB5;
        Wed, 28 Oct 2020 09:49:54 +0000 (UTC)
Date:   Wed, 28 Oct 2020 10:49:52 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Erdem Aktas <erdemaktas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>
Subject: Re: [tip: x86/seves] x86/kvm: Add KVM-specific VMMCALL handling
 under SEV-ES
Message-ID: <20201028094952.GI22179@suse.de>
References: <20200907131613.12703-64-joro@8bytes.org>
 <159972972598.20229.12880317872521101289.tip-bot2@tip-bot2>
 <CAAYXXYx=Eq4gYfUqdO7u37VRD_GpPYFQgN=GZySmAMcDc2AM=g@mail.gmail.com>
 <CAAYXXYw7ZKM+4ZCzn_apb4iy07R5VfcYeyus-kc0ETh_vkBkPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAYXXYw7ZKM+4ZCzn_apb4iy07R5VfcYeyus-kc0ETh_vkBkPg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Oct 27, 2020 at 04:14:15PM -0700, Erdem Aktas wrote:
> It seems to me that the kvm_sev_es_hcall_prepare is leaking more
> information than it is needed. Is this an expected behavior?

What exactly is leaked? The kvm hypercall uses RAX, RBX, RCX, RDX and
RSI for parameters.

Regards,

	Joerg
