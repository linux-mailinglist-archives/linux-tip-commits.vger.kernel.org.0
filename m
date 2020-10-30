Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6106A2A02BA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Oct 2020 11:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgJ3KXR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 30 Oct 2020 06:23:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:42952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgJ3KXR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 30 Oct 2020 06:23:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E11A6AEE0;
        Fri, 30 Oct 2020 10:23:15 +0000 (UTC)
Date:   Fri, 30 Oct 2020 11:23:14 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Erdem Aktas <erdemaktas@google.com>
Cc:     linux-kernel@vger.kernel.org,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>
Subject: Re: [tip: x86/seves] x86/kvm: Add KVM-specific VMMCALL handling
 under SEV-ES
Message-ID: <20201030102314.GP22179@suse.de>
References: <20200907131613.12703-64-joro@8bytes.org>
 <159972972598.20229.12880317872521101289.tip-bot2@tip-bot2>
 <CAAYXXYx=Eq4gYfUqdO7u37VRD_GpPYFQgN=GZySmAMcDc2AM=g@mail.gmail.com>
 <CAAYXXYw7ZKM+4ZCzn_apb4iy07R5VfcYeyus-kc0ETh_vkBkPg@mail.gmail.com>
 <20201028094952.GI22179@suse.de>
 <CAAYXXYwqYeXY3gaExMYX9Pt0nN_D=jbz9FWSuk1hDF8GcK-kfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAYXXYwqYeXY3gaExMYX9Pt0nN_D=jbz9FWSuk1hDF8GcK-kfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 28, 2020 at 11:03:05AM -0700, Erdem Aktas wrote:
> I might be missing something here but I think what you say is only
> correct for the kvm_hypercall4 cases. All other functions use a
> smaller number of registers. #VC blindly assumes that all those
> registers are used in the vmcall and exposes them.

Right, I think we should fix that in the guest and zero out the unused
registers. VMMCALL can come from userspace after all, and the #VC
handler does not look at the hypercall numbers.

Further, on the host side KVM will unconditionally read out all 4
registers too, which requires us to set them valid in the GHCB.

Regards,

	Joerg
