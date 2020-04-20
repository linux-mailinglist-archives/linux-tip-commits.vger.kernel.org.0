Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAFC1B04A5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 20 Apr 2020 10:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDTIm5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 20 Apr 2020 04:42:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:38366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTIm4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 20 Apr 2020 04:42:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E370FAE0F;
        Mon, 20 Apr 2020 08:42:54 +0000 (UTC)
Date:   Mon, 20 Apr 2020 10:42:42 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>
Subject: Re: [tip: ras/core] x86/mce: Add a struct mce.kflags field
Message-ID: <20200420084242.GA20918@zn.tnic>
References: <20200214222720.13168-4-tony.luck@intel.com>
 <158694418849.28353.16699731019695420884.tip-bot2@tip-bot2>
 <20200420080640.GB32592@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420080640.GB32592@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Apr 20, 2020 at 01:06:40AM -0700, Christoph Hellwig wrote:
> Err, how can you add a new field to an uapi structure and not break
> things?

By adding it to the end of the structure. The mcelog tool gets the
record length first, before doing anything with the records.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
